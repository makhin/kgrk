unit InsNewHealthMedicUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, Grids, DBGridEh, ExtCtrls, Buttons, RxLookup,
  DBCtrls, DBLookupEh, DBUtils, CurrEdit;

type
  TInsNewHealthMedicForm = class(TForm)
    Label2: TLabel;
    ComboBoxTreat: TComboBox;
    Panel: TPanel;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    BitBtnPrint: TBitBtn;
    Label1: TLabel;
    MaskEditMKBDiag: TMaskEdit;
    ComboBoxIll: TComboBox;
    ComboBoxHospital: TComboBox;
    ButtonInsHospital: TButton;
    MemoComment: TMemo;
    Label12: TLabel;
    MemoMKBDiagName: TMemo;
    ButtonEditHospital: TButton;
    Label6: TLabel;
    DateEditDoc: TDateEdit;
    Label3: TLabel;
    CurrencyEditSum: TCurrencyEdit;
    PanelMedic: TPanel;
    DBGridEhMedic: TDBGridEh;
    ButtonAdd: TButton;
    ButtonDel: TButton;
    Label4: TLabel;
    CurrencyEditRest: TCurrencyEdit;
    DateEditBegin: TDateEdit;
    Label5: TLabel;
    Label7: TLabel;
    DateEditReport: TDateEdit;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure MaskEditMKBDiagChange(Sender: TObject);
    procedure MaskEditMKBDiagKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonEditHospitalClick(Sender: TObject);
    procedure ButtonInsHospitalClick(Sender: TObject);
    procedure MaskEditMKBDiagEnter(Sender: TObject);
    procedure MemoCommentEnter(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure DBGridEhMedicGetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure CurrencyEditSumChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InsurCaseNum:integer;
    ClientID:integer;
    InsurNum:Integer;
    FactoryNum:Integer;
    TypeInsurCase:Integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure FillComboHospital;
    procedure FillComboTreat;
    procedure FillComboIll;

  end;

var
  InsNewHealthMedicForm: TInsNewHealthMedicForm;

implementation

uses DataUnit, ReportUnit, MainFormUnit, HospitalUnit, ListMKBUnit,
  BranchUnit, InsNewFinUnit;
{$R *.DFM}

procedure TInsNewHealthMedicForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TInsNewHealthMedicForm.FormActivate(Sender: TObject);
begin
 FillComboTreat;
 with DataModuleHM.AsaStoredProcShowInsurCase do
 begin
   Close;
   ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
   Open;
   DateEditDoc.Date:=DataModuleHM.AsaStoredProcShowInsurCaseDocDate.Value;
   DateEditBegin.Date:=DataModuleHM.AsaStoredProcShowInsurCaseBeginDate.AsDateTime;
   DateEditReport.Date:=DataModuleHM.AsaStoredProcShowInsurCaseReportDate.AsDateTime;
   MemoComment.Text:=DataModuleHM.AsaStoredProcShowInsurCaseComment.AsString;
   CurrencyEditSum.Value:=DataModuleHM.AsaStoredProcShowInsurCaseHealthSum.Value;

   MaskEditMKBDiag.Text:=DataModuleHM.AsaStoredProcShowInsurCaseMKBDiagNum.AsString;
   DataModuleHM.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleHM.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleHM.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
   if (InsurCaseNum=-1) then
    begin
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(0));
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(0));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(0));
      BitBtnPrint.Enabled:=False;
      ButtonAdd.Enabled:=False;
      ButtonDel.Enabled:=False;
    end
   else
    begin
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseHospitalNum.AsInteger));
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseTreatNum.AsInteger));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseIllNum.AsInteger));
      BitBtnPrint.Enabled:=True;
      ButtonAdd.Enabled:=True;
      ButtonDel.Enabled:=True;
    end;
   Close;
 end;    // with

  DataModuleHM.AsaStoredProcListMedic.Close;
  DataModuleHM.AsaStoredProcListMedic.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
  DataModuleHM.AsaStoredProcListMedic.Open;

  MaskEditMKBDiag.SetFocus;
end;

procedure TInsNewHealthMedicForm.BitBtnCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TInsNewHealthMedicForm.BitBtnSaveClick(Sender: TObject);
var FirstInsur:Boolean;
  I: Integer;
begin
 FirstInsur:=InsurCaseNum=-1;
 try
   // statements to try
 with DataModuleHM.AsaStoredProcRefrInsurCase do
 begin
     DataModuleHM.AsaSessionHM.StartTransaction;
     for I := 0 to Params.Count-1 do    // Iterate
       Params[I].Clear;

     ParamByName('@LocCode').AsInteger:=DataModuleHM.LocCode;
     ParamByName('@Operator').AsInteger:=DataModuleHM.Operator;
     ParamByName('@InsurCaseNum').AsInteger:=InsurCaseNum;
     ParamByName('@ClientID').AsInteger:=ClientID;
     ParamByName('@FactoryNum').AsInteger:=FactoryNum;
     ParamByName('@InsurNum').AsInteger:=InsurNum;

     ParamByName('@MKBDiagNum').AsString:=MaskEditMKBDiag.Text;
     ParamByName('@HospitalNum').AsInteger:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
     ParamByName('@IllNum').AsInteger:=Integer(ComboBoxIll.Items.Objects[ComboBoxIll.ItemIndex]);
     ParamByName('@TreatNum').AsInteger:=Integer(ComboBoxTreat.Items.Objects[ComboBoxTreat.ItemIndex]);

     ParamByName('@HealthSum').AsCurrency:=CurrencyEditSum.Value;

     if DateEditBegin.Date<>0 then
       ParamByName('@BeginDate').AsDate:=DateEditBegin.Date
     else
       ParamByName('@BeginDate').Clear;

     if DateEditReport.Date<>0 then
       ParamByName('@ReportDate').AsDate:=DateEditReport.Date
     else
       ParamByName('@ReportDate').Clear;

     if DateEditDoc.Date<>0 then
       ParamByName('@DocDate').AsDate:=DateEditDoc.Date
     else
       ParamByName('@DocDate').Clear;

     ParamByName('@Comment').AsString:=MemoComment.Text;
     ParamByName('@TotalSum').AsCurrency:=CurrencyEditSum.Value-CurrencyEditRest.Value;

     ParamByName('@TypeInsurCase').AsInteger:=TypeInsurCase;

     ExecProc;
     InsurCaseNum:=ParamByName('@InsurCaseNum').AsInteger;
     DataModuleHM.AsaSessionHM.Commit;

     if FirstInsur then
      begin
       if (MessageDlg('Будем выдавать мед-ты?',mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
         begin
          ButtonAdd.Enabled:=True;
          ButtonDel.Enabled:=True;
          ButtonAddClick(Sender);
         end
       else
         InsNewHealthMedicForm.Close;
      end
     else
       InsNewHealthMedicForm.Close;
 end;    // with
 except
   on e: Exception do
    begin
     DataModuleHM.AsaSessionHM.Rollback;
     ShowMessage('Ошибка сохранения '+e.Message);
    end;
 end;    // try/except
end;

procedure TInsNewHealthMedicForm.FillComboHospital;
begin
 with DataModuleHM.AsaStoredProcListHospital do
 begin
   Open;
   ComboBoxHospital.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxHospital.Items.AddObject(DataModuleHM.AsaStoredProcListHospitalHospitalName.AsString,TObject(DataModuleHM.AsaStoredProcListHospitalHospitalNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;

procedure TInsNewHealthMedicForm.FillComboIll;
begin
 with DataModuleHM.AsaStoredProcListIll do
 begin
   Open;
   ComboBoxIll.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxIll.Items.AddObject(DataModuleHM.AsaStoredProcListIllIllName.AsString,TObject(DataModuleHM.AsaStoredProcListIllIllNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;

procedure TInsNewHealthMedicForm.FillComboTreat;
begin
 with DataModuleHM.AsaStoredProcListTreatment do
 begin
   ParamByName('@TypeInsurCase').Value:=TypeInsurCase;
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


procedure TInsNewHealthMedicForm.FormCreate(Sender: TObject);
begin
   FillComboHospital;
   FillComboIll;
end;

procedure TInsNewHealthMedicForm.BitBtnPrintClick(Sender: TObject);
begin
  ReportModuleHM.PrintInsurCase(InsurCaseNum);
end;


procedure TInsNewHealthMedicForm.MaskEditMKBDiagChange(Sender: TObject);
begin
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
   DataModuleHM.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleHM.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleHM.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
end;

procedure TInsNewHealthMedicForm.MaskEditMKBDiagKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key=VK_F1) then
  begin
   ListMKBDiagForm.ShowModal;
   MaskEditMKBDiag.Text:=DataModuleHM.AsaStoredProcListMKBDiagMKBDiagNum.Value;
   MaskEditMKBDiagChange(Sender);
  end;
end;

procedure TInsNewHealthMedicForm.ButtonEditHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewHealthMedicForm.ButtonInsHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=-1;
  ShowModal;
 end;    // with
end;

procedure TInsNewHealthMedicForm.MaskEditMKBDiagEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000409', KLF_ACTIVATE); // английский
end;

procedure TInsNewHealthMedicForm.MemoCommentEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

procedure TInsNewHealthMedicForm.ButtonAddClick(Sender: TObject);
begin
  InsFinForm.InsurCaseNum:=InsurCaseNum;
  InsFinForm.ShowModal;
  DataModuleHM.AsaStoredProcListMedic.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
  RefreshQuery(DataModuleHM.AsaStoredProcListMedic);
end;

procedure TInsNewHealthMedicForm.ButtonDelClick(Sender: TObject);
begin
  if DataModuleHM.AsaStoredProcListMedicFinance.Value<0 then
    begin
      ShowMessage('Нельзя делать откат на откат');
      Exit;
    end;

  if MessageDlg('Вы уверены, что хотите сделать откат?',
    mtConfirmation, [mbYes,mbNo], 0) = mrNo then Exit;

  with DataModuleHM.AsaStoredProcUnMedic do
  begin
    ParamByName('@LocCode').Value:=DataModuleHM.LocCode;
    ParamByName('@MedicNum').Value:=DataModuleHM.AsaStoredProcListMedicMedicNum.Value;
    ExecProc;
  end;    // with
  RefreshQuery(DataModuleHM.AsaStoredProcListMedic);
end;

procedure TInsNewHealthMedicForm.DBGridEhMedicGetFooterParams(
  Sender: TObject; DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  if Column.Field.FullName='Finance' then
   CurrencyEditRest.Value:=CurrencyEditSum.Value-StrToFloat(Text);
end;

procedure TInsNewHealthMedicForm.CurrencyEditSumChange(Sender: TObject);
begin
   DBGridEhMedic.SumList.RecalcAll;
end;

end.
