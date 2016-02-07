unit InsNewMaxInsurUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, CurrEdit, DBUtils;

type
  TMaxInsurForm = class(TForm)
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    Label1: TLabel;
    EditMaxInsurName: TEdit;
    Label3: TLabel;
    EditComment: TEdit;
    Label4: TLabel;
    ComboBoxLic: TComboBox;
    ButtonAdd: TButton;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MaxInsurNum:integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure FillComboBox;
  end;

var
  MaxInsurForm: TMaxInsurForm;

implementation

uses DataUnit, MainFormUnit, InsNewLicUnit, InsNewClientUnit;

{$R *.DFM}

procedure TMaxInsurForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TMaxInsurForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TMaxInsurForm.FormActivate(Sender: TObject);
begin
 with DataModuleHM.AsaStoredProcShowMaxInsur do
 begin
   ParamByName('@MaxInsurNum').Value:=MaxInsurNum;
   Open;
   EditMaxInsurName.Text:=DataModuleHM.AsaStoredProcShowMaxInsurMaxInsurName.Value;
   EditComment.Text:=DataModuleHM.AsaStoredProcShowMaxInsurComment.Value;
   ComboBoxLic.ItemIndex:=ComboBoxLic.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowMaxInsurLicNum.Value));
   Close;
 end;    // with
end;

procedure TMaxInsurForm.BitBtnSaveClick(Sender: TObject);
begin
 if EditMaxInsurName.Text='' then
 begin
  ShowMessage('Введи Название');
  EditMaxInsurName.SetFocus;
  Exit;
 end;
 try
   // statements to try
 with DataModuleHM.AsaStoredProcRefrMaxInsur do
 begin
     ParamByName('@InsurNum').AsInteger:=MaxInsurNum;
     ParamByName('@InsurName').AsString:=EditMaxInsurName.Text;
     ParamByName('@Comment').AsString:=EditComment.Text;
     if ComboBoxLic.ItemIndex=-1 then
       ParamByName('@LicNum').Clear
     else
       ParamByName('@LicNum').AsInteger:=Integer(ComboBoxLic.Items.Objects[ComboBoxLic.ItemIndex]);
     ExecProc;
     MaxInsurNum:=ParamByName('@InsurNum').AsInteger;
     DataModuleHM.AsaSessionHM.Commit;

     with InsNewClientForm.ComboBoxMaxInsur do
     begin
       Items.AddObject(EditMaxInsurName.Text, TObject(MaxInsurNum));
       ItemIndex:=Items.Count-1;
     end;    // with

     RefreshQuery(DataModuleHM.AsaStoredProcListMaxInsur);
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

procedure TMaxInsurForm.FillComboBox;
begin
 with DataModuleHM.AsaStoredProcListLicenses do
 begin
   Open;
   ComboBoxLic.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxLic.Items.AddObject(DataModuleHM.AsaStoredProcListLicensesLicName.AsString, TObject(DataModuleHM.AsaStoredProcListLicensesLicNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;

procedure TMaxInsurForm.FormCreate(Sender: TObject);
begin
  FillComboBox;
end;

procedure TMaxInsurForm.ButtonAddClick(Sender: TObject);
begin
 with NewLicForm do
 begin
  LicNum:=-1;
  ShowModal;
 end;    // with

end;

end.
