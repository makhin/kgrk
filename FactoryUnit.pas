unit FactoryUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TFactoryForm = class(TForm)
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    MemoFactoryName: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure MemoFactoryNameEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FactoryNum:integer;
    procedure CMDialogKey(var Message: TCMDialogKey);

  end;

var
  FactoryForm: TFactoryForm;

implementation

uses DataUnit, InsNewClientUnit;

{$R *.DFM}

procedure TFactoryForm.CMDialogKey(var Message: TCMDialogKey);
begin
// Enter to Tab
  with Message do
  begin
   case CharCode of
        VK_RETURN:
           CharCode := VK_TAB;
   end;
  end;
  inherited;
end;

procedure TFactoryForm.FormActivate(Sender: TObject);
begin
 with DataModuleHM.AsaStoredProcShowFactory do
 begin
   ParamByName('@FactoryNum').Value:=FactoryNum;
   Open;
   MemoFactoryName.Text:=DataModuleHM.AsaStoredProcShowFactoryFactoryName.Value;
   Close;
 end;    // with
 MemoFactoryName.SetFocus;
end;

procedure TFactoryForm.BitBtnSaveClick(Sender: TObject);
var new:Boolean;
begin
 new:=FactoryNum=-1;
 if MemoFactoryName.Text='' then
 begin
  ShowMessage('Введи Название');
  MemoFactoryName.SetFocus;
  Exit;
 end;
 try
   // statements to try
 begin
  with DataModuleHM do
  begin
   AsaSessionHM.StartTransaction;
   AsaStoredProcRefrFactory.ParamByName('@FactoryNum').Value:=FactoryNum;
   AsaStoredProcRefrFactory.ParamByName('@FactoryName').Value:=MemoFactoryName.Text;
   AsaStoredProcRefrFactory.ExecProc;
   FactoryNum:=AsaStoredProcRefrFactory.ParamByName('@FactoryNum').Value;
   AsaSessionHM.Commit;
  end;
  if new then
    with InsNewClientForm.ComboBoxFactory do
    begin
      Items.AddObject(MemoFactoryName.Text, TObject(FactoryNum));
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

procedure TFactoryForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFactoryForm.MemoFactoryNameEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

end.
