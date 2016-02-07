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
    Label2: TLabel;
    CurrencyEditMaxInsurMoney: TCurrencyEdit;
    Label3: TLabel;
    EditComment: TEdit;
    Label4: TLabel;
    ComboBoxLic: TComboBox;
    ButtonAdd: TButton;
    Label5: TLabel;
    CurrencyEditMaxInsurPayment: TCurrencyEdit;
    ComboBoxTreat: TComboBox;
    Label6: TLabel;
    ButtonSaveLimit: TButton;
    CurrencyEditLimit: TCurrencyEdit;
    Label7: TLabel;
    CurrencyEditMedLim: TCurrencyEdit;
    CurrencyEditServLim: TCurrencyEdit;
    Label8: TLabel;
    Label9: TLabel;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ComboBoxTreatChange(Sender: TObject);
    procedure ButtonSaveLimitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MaxInsurNum:integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure FillComboBox;
    procedure FillComboTreat;
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
   CurrencyEditMaxInsurMoney.Value:=DataModuleHM.AsaStoredProcShowMaxInsurMaxInsurMoney.Value;
   CurrencyEditMaxInsurPayment.Value:=DataModuleHM.AsaStoredProcShowMaxInsurMaxInsurPayment.Value;
   EditComment.Text:=DataModuleHM.AsaStoredProcShowMaxInsurComment.Value;
   ComboBoxLic.ItemIndex:=ComboBoxLic.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowMaxInsurLicNum.Value));
   ComboBoxTreat.ItemIndex:= ComboBoxTreat.Items.IndexOfObject(TObject(0));
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
     ParamByName('@MaxInsurMoney').AsCurrency:=CurrencyEditMaxInsurMoney.Value;
     ParamByName('@MaxInsurPayment').AsCurrency:=CurrencyEditMaxInsurPayment.Value;
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

procedure TMaxInsurForm.FillComboTreat;
begin
 with DataModuleHM.AsaStoredProcListTreatment do
 begin
   ParamByName('@MaxInsurNum').Clear;
   Open;
   ComboBoxTreat.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxTreat.Items.AddObject(DataModuleHM.AsaStoredProcListTreatmentTreatName.AsString,TObject(DataModuleHM.AsaStoredProcListTreatmentTreatNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;


procedure TMaxInsurForm.FormCreate(Sender: TObject);
begin
  FillComboBox;
  FillComboTreat;
end;

procedure TMaxInsurForm.ButtonAddClick(Sender: TObject);
begin
 with NewLicForm do
 begin
  LicNum:=-1;
  ShowModal;
 end;    // with

end;

procedure TMaxInsurForm.ComboBoxTreatChange(Sender: TObject);
begin
  with DataModuleHM.AsaStoredProcGetLimit do
  begin
    ParamByName('@MaxInsurNum').AsInteger:=MaxInsurNum;
    ParamByName('@TreatNum').AsInteger:=Integer(ComboBoxTreat.Items.Objects[ComboBoxTreat.ItemIndex]);
    Open;
    CurrencyEditLimit.Value := DataModuleHM.AsaStoredProcGetLimitLimit.Value;
    CurrencyEditMedLim.Value :=DataModuleHM.AsaStoredProcGetLimitMedLimit.Value;
    CurrencyEditServLim.Value :=DataModuleHM.AsaStoredProcGetLimitServLimit.Value;
    Close;
  end;    // with
end;

procedure TMaxInsurForm.ButtonSaveLimitClick(Sender: TObject);
begin
 try
 with DataModuleHM.AsaStoredProcRefrLimit do
 begin
     ParamByName('@MaxInsurNum').AsInteger:=MaxInsurNum;
     ParamByName('@TreatNum').AsInteger:=Integer(ComboBoxTreat.Items.Objects[ComboBoxTreat.ItemIndex]);
     ParamByName('@Limit').AsCurrency:=CurrencyEditLimit.Value;
     ParamByName('@MedLimit').AsCurrency:=CurrencyEditMedLim.Value;
     ParamByName('@ServLimit').AsCurrency:=CurrencyEditServLim.Value;
     ExecProc;
     DataModuleHM.AsaSessionHM.Commit;
 end;    // with
 except
   on e: Exception do
     begin
       DataModuleHM.AsaSessionHM.Rollback;
       ShowMessage('Ошибка сохранения '+e.Message);
     end;
 end;    // try/except
end;

end.
