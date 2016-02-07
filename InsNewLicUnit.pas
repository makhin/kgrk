unit InsNewLicUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TNewLicForm = class(TForm)
    Label1: TLabel;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    EditLicName: TEdit;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LicNum:integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  end;

var
  NewLicForm: TNewLicForm;

implementation

uses DataUnit, MainFormUnit, InsNewMaxInsurUnit;

{$R *.DFM}

procedure TNewLicForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TNewLicForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TNewLicForm.BitBtnSaveClick(Sender: TObject);
begin
 if EditLicName.Text='' then
 begin
  ShowMessage('Введи Название');
  EditLicName.SetFocus;
  Exit;
 end;
 try
   // statements to try
 with DataModuleHM.AsaStoredProcRefrLic do
 begin
     DataModuleHM.AsaSessionHM.StartTransaction;
     ParamByName('@LicNum').AsInteger:=LicNum;
     ParamByName('@LicName').AsString:=EditLicName.Text;
     ExecProc;
     LicNum:=ParamByName('@LicNum').AsInteger;
     DataModuleHM.AsaSessionHM.Commit;
     with MaxInsurForm.ComboBoxLic do
     begin
       Items.AddObject(EditLicName.Text, TObject(LicNum));
       ItemIndex:=Items.Count-1;
     end;    // with
 end;    // with
 except
   on e: Exception do
     begin
       DataModuleHM.AsaSessionHM.Rollback;
       ShowMessage('Ошибка сохранения '+e.Message);
     end;
 end;    // try/except
 Close;
end;

end.
