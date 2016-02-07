unit InsNewFinFactUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, CurrEdit, Mask, ToolEdit;

type
  TInsNewFinFactForm = class(TForm)
    Label1: TLabel;
    DateEditFinFactDate: TDateEdit;
    Label2: TLabel;
    EditContract: TEdit;
    Label3: TLabel;
    ComboBoxType: TComboBox;
    Label4: TLabel;
    CurrencyEditFinance: TCurrencyEdit;
    Label5: TLabel;
    ComboBoxHospital: TComboBox;
    Label6: TLabel;
    DateEditDeliverDate: TDateEdit;
    EditComment: TEdit;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    ButtonEditType: TButton;
    ButtonInsType: TButton;
    ButtonEditRec: TButton;
    ButtonInsRec: TButton;
    Label7: TLabel;
    ComboBoxMaxInsur: TComboBox;
    Label8: TLabel;
    ComboBoxFactory: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure ButtonEditTypeClick(Sender: TObject);
    procedure ButtonInsTypeClick(Sender: TObject);
    procedure ButtonEditRecClick(Sender: TObject);
    procedure ButtonInsRecClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FinFactNum:Integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure FillComboType;
  end;

var
  InsNewFinFactForm: TInsNewFinFactForm;

implementation

uses DataUnit, MainFormUnit, FinFactTypeUnit,
  InsNewClientUnit, HospitalUnit, InsNewMedUnit;

{$R *.DFM}

procedure TInsNewFinFactForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TInsNewFinFactForm.FillComboType;
begin
 with DataModuleHM.AsaStoredProcListFinFactType do
 begin
   Open;
   ComboBoxType.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxType.Items.AddObject(DataModuleHM.AsaStoredProcListFinFactTypeFinFactTypeName.AsString,TObject(DataModuleHM.AsaStoredProcListFinFactTypeFinFactTypeNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;


procedure TInsNewFinFactForm.FormActivate(Sender: TObject);
begin
 FillComboType;
 ComboBoxMaxInsur.Items.Assign(InsNewClientForm.ComboBoxMaxInsur.Items);
 ComboBoxFactory.Items.Assign(InsNewClientForm.ComboBoxFactory.Items);
 ComboBoxHospital.Items.Assign(InsNewMedForm.ComboBoxHospital.Items);
 with DataModuleHM.AsaStoredProcShowFinFact do
 begin
   Close;
   ParamByName('@FinFactNum').Value:=FinFactNum;
   Open;
   DateEditFinFactDate.Date:=DataModuleHM.AsaStoredProcShowFinFactFinFactDate.AsDateTime;
   DateEditDeliverDate.Date:=DataModuleHM.AsaStoredProcShowFinFactDateDeliver.AsDateTime;
   EditComment.Text:=DataModuleHM.AsaStoredProcShowFinFactComment.Value;
   EditContract.Text:=DataModuleHM.AsaStoredProcShowFinFactContract.Value;
   CurrencyEditFinance.Value:=DataModuleHM.AsaStoredProcShowFinFactFinance.Value;
   if (FinFactNum=-1) then
    begin
      ComboBoxType.ItemIndex:=ComboBoxType.Items.IndexOfObject(TObject(1));
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(0));
      ComboBoxMaxInsur.ItemIndex:=ComboBoxMaxInsur.Items.IndexOfObject(TObject(1));
      ComboBoxFactory.ItemIndex:=ComboBoxFactory.Items.IndexOfObject(TObject(0));
    end
   else
    begin
      ComboBoxType.ItemIndex:=ComboBoxType.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowFinFactFinFactTypeNum.AsInteger));
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowFinFactHospitalNum.AsInteger));
      ComboBoxMaxInsur.ItemIndex:=ComboBoxMaxInsur.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowFinFactInsurNum.AsInteger));
      ComboBoxFactory.ItemIndex:=ComboBoxFactory.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowFinFactFactoryNum.AsInteger));
    end;
   Close;
 end;    // with
  DateEditFinFactDate.SetFocus;
end;

procedure TInsNewFinFactForm.BitBtnSaveClick(Sender: TObject);
begin
 try
   // statements to try
 with DataModuleHM.AsaStoredProcRefrFinFact do
 begin
     ParamByName('@FinFactNum').AsInteger:=FinFactNum;
     ParamByName('@Finance').AsCurrency:=CurrencyEditFinance.Value;
     ParamByName('@Contract').AsString:=EditContract.Text;
     ParamByName('@Comment').AsString:=EditComment.Text;
     ParamByName('@FinFactTypeNum').AsInteger:=Integer(ComboBoxType.Items.Objects[ComboBoxType.ItemIndex]);
     ParamByName('@HospitalNum').AsInteger:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
     ParamByName('@InsurNum').AsInteger:=Integer(ComboBoxMaxInsur.Items.Objects[ComboBoxMaxInsur.ItemIndex]);
     ParamByName('@FactoryNum').AsInteger:=Integer(ComboBoxFactory.Items.Objects[ComboBoxFactory.ItemIndex]);

     if DateEditFinFactDate.Date<>0 then
       ParamByName('@FinFactDate').AsDate:=DateEditFinFactDate.Date
     else
       ParamByName('@FinFactDate').Clear;

     if DateEditDeliverDate.Date<>0 then
       ParamByName('@DateDeliver').AsDate:=DateEditDeliverDate.Date
     else
       ParamByName('@DateDeliver').Clear;

     ExecProc;
     FinFactNum:=ParamByName('@FinFactNum').AsInteger;
 end;    // with
 except
   on e: Exception do
    begin
     DataModuleHM.AsaSessionHM.Rollback;
     ShowMessage('Ошибка сохранения '+e.Message);
    end;
 end;    // try/except

end;

procedure TInsNewFinFactForm.BitBtnCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TInsNewFinFactForm.ButtonEditTypeClick(Sender: TObject);
begin
 with FinFactTypeForm do
 begin
    FinFactTypeNum:=Integer(ComboBoxType.Items.Objects[ComboBoxType.ItemIndex]);
    ShowModal;
 end;    // with
end;

procedure TInsNewFinFactForm.ButtonInsTypeClick(Sender: TObject);
begin
 with FinFactTypeForm do
 begin
    FinFactTypeNum:=-1;
    ShowModal;
 end;    // with
end;

procedure TInsNewFinFactForm.ButtonEditRecClick(Sender: TObject);
begin
 with HospitalForm do
 begin
    HospitalNum:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
    ShowModal;
 end;    // with
end;

procedure TInsNewFinFactForm.ButtonInsRecClick(Sender: TObject);
begin
 with HospitalForm do
 begin
    HospitalNum:=-1;
    ShowModal;
 end;    // with
end;

end.
