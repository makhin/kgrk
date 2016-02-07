unit AboutUnit;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Dialogs;

type
  TAboutBox = class(TForm)
    OKButton: TButton;
    OpenDialogUpdate: TOpenDialog;
    Panel1: TPanel;
    Label1: TLabel;
    ButtonPass: TButton;
    procedure FormActivate(Sender: TObject);
    procedure SecretPanelDblClick(Sender: TObject);
    procedure ButtonPassClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses DataUnit, LibUnit;
{$R *.DFM}

procedure TAboutBox.FormActivate(Sender: TObject);
begin

OpenDialogUpdate.InitialDir:=ExtractFileDir(Application.ExeName)+'\Update';
end;

procedure TAboutBox.SecretPanelDblClick(Sender: TObject);
var f:TextFile;
    S: string;
    cs: string;
begin
 try
  if OpenDialogUpdate.Execute then
   begin
     AssignFile(f,OpenDialogUpdate.FileName);
     Reset(f);
     s:='';
     while not Eof(f) do
     begin
       Readln(f,cs);
       s:=s+' '+cs+#10+#13;
     end;    // while
     CloseFile(f);
     DataModuleHM.AsaSQLUpdate.Execute(s, null);
     ShowMessage('Обновление успешно завершено');
   end;
 except
   on e: Exception do
     ShowMessage('Ошибка обновления '+e.Message);
 end;    // try/except

end;

procedure TAboutBox.ButtonPassClick(Sender: TObject);
var password1, password2 :string;
begin
  password1:=InputPassword('Смена пароля', 'Введите новый пароль');
  if password1='' then
    Exit;
  password2:=InputPassword('Смена пароля', 'Повторите новый пароль');
  if password1<>password2 then
    begin
      ShowMessage ('Пароли должены совпадать');
      Exit;
    end
  else
    begin
      DataModuleHM.AsaSQLUpdate.ExecuteImmediate('GRANT CONNECT TO userdim IDENTIFIED BY '+password1);
      ShowMessage ('Пароль успешно изменен');
    end;
end;

end.

