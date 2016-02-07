unit FinFactTypeUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TFinFactTypeForm = class(TForm)
    MemoFinFactTypeName: TMemo;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure MemoFinFactTypeNameEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FinFactTypeNum:Integer;
  end;

var
  FinFactTypeForm: TFinFactTypeForm;

implementation

uses DataUnit, InsNewFinFactUnit;

{$R *.DFM}

procedure TFinFactTypeForm.BitBtnCancelClick(Sender: TObject);
begin
 Close;
end;


procedure TFinFactTypeForm.FormActivate(Sender: TObject);
begin
  with DataModuleHM.AsaStoredProcShowFinFactType do
 begin
   ParamByName('@FinFactTypeNum').Value:=FinFactTypeNum;
   Open;
   MemoFinFactTypeName.Text:=DataModuleHM.AsaStoredProcShowFinFactTypeFinFactTypeName.Value;
   Close;
 end;    // with
 MemoFinFactTypeName.SetFocus;

end;

procedure TFinFactTypeForm.BitBtnSaveClick(Sender: TObject);
var new:Boolean;
begin
 new:=FinFactTypeNum=-1;
 if MemoFinFactTypeName.Text='' then
 begin
  ShowMessage('Введи Название');
  MemoFinFactTypeName.SetFocus;
  Exit;
 end;
 try
   // statements to try
 begin
  with DataModuleHM do
  begin
   AsaSessionHM.StartTransaction;
   AsaStoredProcRefrFinFactType.ParamByName('@FinFactTypeNum').Value:=FinFactTypeNum;
   AsaStoredProcRefrFinFactType.ParamByName('@FinFactTypeName').Value:=MemoFinFactTypeName.Text;
   AsaStoredProcRefrFinFactType.ExecProc;
   FinFactTypeNum:=AsaStoredProcRefrFinFactType.ParamByName('@FinFactTypeNum').Value;
   AsaSessionHM.Commit;
  end;
  if new then
    with InsNewFinFactForm.ComboBoxType do
    begin
      Items.AddObject(MemoFinFactTypeName.Text, TObject(FinFactTypeNum));
      ItemIndex:=Items.Count-1;
    end;    // with
  end;
 except
   on e: Exception do
    begin
      ShowMessage('Ошибка '+ e.Message);
      DataModuleHM.AsaSessionHM.RollBack;
    end;
 end;    // try/except
  Close;
end;

procedure TFinFactTypeForm.MemoFinFactTypeNameEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

end.
