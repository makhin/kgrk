unit LibUnit;

interface

function IntToDate(Val:Integer):TDateTime ;
function NumOffice(f:string):integer; // возвращает номер оффиса по имени импорта
function NumBatch(f:string):integer;  // возвращает номер импорта
function CharToInt(f:string):Cardinal; // конвертирует
function Trial:Boolean;
function UAH(f:double):string;
function QNT(i:integer):string;
function InputPassword(const ACaption, APrompt: string): string;

implementation

uses SysUtils, Forms, stdctrls, Windows,
     Messages, CommDlg, Classes, Graphics, Controls;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

function InputPassword(const ACaption, APrompt: string): string;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := '';
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      ClientHeight := MulDiv(63, DialogUnits.Y, 8);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        AutoSize := True;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Caption := APrompt;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        PasswordChar := '*'; 
        Parent := Form;
        Left := Prompt.Left;
        Top := MulDiv(19, DialogUnits.Y, 8);
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
      end;
      ButtonTop := MulDiv(41, DialogUnits.Y, 8);
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := '¬вод';
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := 'ќтмена';
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      if ShowModal = mrOk then
        Result := Edit.Text;
    finally
      Form.Free;
    end;
end;


function NumOffice(f:string):integer; // возвращает номер оффиса по имени импорта
begin
 try
  result := StrToInt(f[1]);
 except
  result:=0;
 end;    // try/finally
end;

function NumBatch(f:string):integer;  // возвращает номер импорта
begin
 try
  result := StrToInt(f[2]+f[3]+f[4]+f[5]+f[6]+f[7]);
 except
  result :=0;
 end;
end;


function IntToDate(Val:Integer):TDateTime ;
var Year, Month, Day:Word;
begin
 if Val=0 then
  begin
   Result:=0;
   Exit;
  end;
try
  // statements to try
 Day:=Trunc(Val/1000000);
 Month:=Trunc((Val-Day*1000000)/10000);
 Year:=Val-Day*1000000-Month*10000;
 Result:=EncodeDate(Year,Month,Day);
except
  on e: Exception do
  Result:=0;
end;    // try/except

end;

function CharToInt(f:string):Cardinal;
begin
try
  // statements to try
  Result:=StrToInt(f);
except
  on e: Exception do
  Result:=0;
end;    // try/except

end;


function Trial:Boolean;
begin
  Result:=False;
//  if Now()>EncodeDate(2003,11,15) then
//   Result:=True;

end;

function UAH(f:double):string;
 var g,p,s:string;var a,w:byte; gg,ii:integer;
 const
  Odyn:array[false..true,'1'..'9']of string[7] =
   (('одна','две','три','четыре','п€ть','шесть','семь','восемь','дев€ть'),
    ('один','два','три','четыре','п€ть','шесть','семь','восемь','дев€ть'));
  Teen:array[10..19]of string[13] =
   ('дес€ть','одинадцать','двенадцать','тринадцать','четырнадцать',
    'п€тнадцать','шестнадцать','семнадцать','восемнадцать','дев€тнадцать');
  Des:array['2'..'9']of string[10] =
   ('двадцать','тридцать','сорок','п€тьдес€т','шестьдес€т',
    'семьдес€т','восемдес€т','дев€носто');
  Sot:array['1'..'9']of string[9] =
   ('сто','двести','триста','четыреста','п€тьсот','шестьсот','семьсот',
    'восемьсот','дев€тьсот');
  Nam:array[1..3,0..4]of string[13] =
   (('гривн€','тыс€ча','миллион','миллиард','триллион'),
    ('гривни','тыс€чи','миллиона','миллиарда','триллиона'),
    ('гривен','тыс€ч','миллионов','миллиардов','триллионов'));

 begin
  str(f:21:2,s);
  g:=' '+Copy(s,length(s)-1,2)+' коп.';
  s:=Copy(s,1,length(s)-3);
  for a:=(length(s) div 3)-1 downto 0 do begin
   Val(Copy(s,3*a+2,2),gg,ii);if ii>0 then continue;
   p:='';w:=3;
   if not (s[3*a+1] in [' ','0']) then p:=p+' '+Sot[s[3*a+1]];
   if (gg>9)and(gg<20) then
    p:=p+' '+Teen[gg]
   else
    begin
     if (not (s[3*a+2] in [' ','0'])) then p:=p+' '+Des[s[3*a+2]];
     if (s[3*a+3]<>'0') then
      begin
       p:=p+' '+Odyn[(length(s) div 3)-1-a>=2,s[3*a+3]];
       case s[3*a+3] of
        '1'     :w:=1;
        '2'..'4':w:=2;
       end;
      end;
    end;
    if (length(p)>0) or ((length(s) div 3)-1=a) then
      g:=p+' '+Nam[w,(length(s) div 3)-1-a]+g;
  end;
  if g[2]='грн.' then g:='нуль'+g else
  g:=Copy(g,2,255);
  UAH:=g;
 end;

function QNT(i:integer):string;
 var g,p,s:string;var a,w:byte; gg,ii:integer;
 const
  Odyn:array[false..true,'1'..'9']of string[7] =
   (('одна','две','три','четыре','п€ть','шесть','семь','восемь','дев€ть'),
    ('один','два','три','четыре','п€ть','шесть','семь','восемь','дев€ть'));
  Teen:array[10..19]of string[13] =
   ('дес€ть','одинадцать','двенадцать','тринадцать','четырнадцать',
    'п€тнадцать','шестнадцать','семнадцать','восемнадцать','дев€тнадцать');
  Des:array['2'..'9']of string[10] =
   ('двадцать','тридцать','сорок','п€тьдес€т','шестьдес€т',
    'семьдес€т','восемдес€т','дев€носто');
  Sot:array['1'..'9']of string[9] =
   ('сто','двести','триста','четыреста','п€тьсот','шестьсот','семьсот',
    'восемьсот','дев€тьсот');
  Nam:array[1..3,0..4]of string[13] =
   (('штука','тыс€ча','миллион','миллиард','триллион'),
    ('штуки','тыс€чи','миллиона','миллиарда','триллиона'),
    ('штук','тыс€ч','миллионов','миллиардов','триллионов'));

 begin
  str(i:21,s);
  for a:=(length(s) div 3)-1 downto 0 do
  begin
   Val(Copy(s,3*a+2,2),gg,ii);if ii>0 then continue;
   p:='';w:=3;
   if not (s[3*a+1] in [' ','0']) then p:=p+' '+Sot[s[3*a+1]];
   if (gg>9)and(gg<20) then
    p:=p+' '+Teen[gg]
   else
    begin
     if (not (s[3*a+2] in [' ','0'])) then p:=p+' '+Des[s[3*a+2]];
     if (s[3*a+3]<>'0') then
      begin
       p:=p+' '+Odyn[(length(s) div 3)-1-a>=2,s[3*a+3]];
       case s[3*a+3] of
        '1'     :w:=1;
        '2'..'4':w:=2;
       end;
      end;
    end;
    if (length(p)>0) or ((length(s) div 3)-1=a) then
      g:=p+' '+Nam[w,(length(s) div 3)-1-a]+g;
  end;
  QNT:=g;
 end;



end.
