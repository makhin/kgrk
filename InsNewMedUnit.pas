unit InsNewMedUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, Grids, DBGridEh, ExtCtrls, Buttons, RxLookup,
  DBCtrls, DBLookupEh, DBUtils, CurrEdit;

type
  TInsNewMedForm = class(TForm)
    Label2: TLabel;
    ComboBoxTreat: TComboBox;
    Label3: TLabel;
    DateEditEnd: TDateEdit;
    Label4: TLabel;
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
    Label5: TLabel;
    ComboBoxBranch: TComboBox;
    ButtonEditBranch: TButton;
    Label6: TLabel;
    RadioGroupIsTariff: TRadioGroup;
    CurrencyEditTariff: TCurrencyEdit;
    CurrencyEditSum: TCurrencyEdit;
    Label7: TLabel;
    CheckBoxIndust: TCheckBox;
    Label8: TLabel;
    CurrencyEditMedical: TCurrencyEdit;
    CurrencyEditFood: TCurrencyEdit;
    CheckBoxAddAkt: TCheckBox;
    Label10: TLabel;
    DateEditProtocol: TDateEdit;
    Label11: TLabel;
    EditAkt: TEdit;
    Label13: TLabel;
    CurrencyEditRest: TCurrencyEdit;
    Label9: TLabel;
    Label14: TLabel;
    DateEditAktDate: TDateEdit;
    PanelMedic: TPanel;
    DBGridEhMedic: TDBGridEh;
    ButtonAdd: TButton;
    ButtonDel: TButton;
    Label15: TLabel;
    CurrencyEditPayPercent: TCurrencyEdit;
    Label16: TLabel;
    CurrencyEditDiag: TCurrencyEdit;
    Label17: TLabel;
    CurrencyEditTotal: TCurrencyEdit;
    DateEditBegin: TDateEdit;
    EditLimit: TEdit;
    Label18: TLabel;
    DateEditDoc: TDateEdit;
    PanelLim: TPanel;
    EditLimitServ: TEdit;
    EditLimitMed: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
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
    procedure ButtonEditBranchClick(Sender: TObject);
    procedure ButtonAddBranchClick(Sender: TObject);
    procedure ComboBoxHospitalChange(Sender: TObject);
    procedure CurrencyEditLimitChange(Sender: TObject);
    procedure ReCalc(Sender: TObject);
    procedure ComboBoxBranchChange(Sender: TObject);
    procedure CheckBoxAddAktClick(Sender: TObject);
    procedure RadioGroupIsTariffClick(Sender: TObject);
    procedure ComboBoxTreatChange(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InsurCaseNum:integer;
    ClientID:integer;
    InsurNum:Integer;
    FactoryNum:Integer;
    BedDay, Limit, LimitMed, LimitServ  :Currency;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure FillComboHospital;
    procedure FillComboBranch(hn:integer);
    procedure FillComboTreat;
    procedure FillComboIll;
    procedure GetBedDay;
    procedure GetLimit;
  end;

var
  InsNewMedForm: TInsNewMedForm;

implementation

uses DataUnit, ReportUnit, MainFormUnit, HospitalUnit, ListMKBUnit,
  BranchUnit, InsNewHealthMedicUnit, InsNewFinUnit;
{$R *.DFM}

procedure TInsNewMedForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TInsNewMedForm.FormActivate(Sender: TObject);
begin
 FillComboTreat;
 with DataModuleHM.AsaStoredProcShowInsurCase do
 begin
   Close;
   ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
   Open;
   CurrencyEditMedical.Value:=DataModuleHM.AsaStoredProcShowInsurCaseMedSum.Value;
   CheckBoxAddAkt.Checked:=DataModuleHM.AsaStoredProcShowInsurCaseAddAkt.Value;
   CurrencyEditFood.Value:=DataModuleHM.AsaStoredProcShowInsurCaseAddMedSum.Value;
   DateEditProtocol.Date:=DataModuleHM.AsaStoredProcShowInsurCaseReportDate.Value;
   CheckBoxIndust.Checked:=DataModuleHM.AsaStoredProcShowInsurCaseIsIndust.Value;
   EditAkt.Text:=DataModuleHM.AsaStoredProcShowInsurCaseAkt.Value;
   DateEditAktDate.Date:=DataModuleHM.AsaStoredProcShowInsurCaseAktDate.Value;
   DateEditBegin.Date:=DataModuleHM.AsaStoredProcShowInsurCaseBeginDate.AsDateTime;
   DateEditEnd.Date:=DataModuleHM.AsaStoredProcShowInsurCaseEndDate.AsDateTime;
   DateEditDoc.Date:=DataModuleHM.AsaStoredProcShowInsurCaseDocDate.AsDateTime;
   MemoComment.Text:=DataModuleHM.AsaStoredProcShowInsurCaseComment.AsString;
   MaskEditMKBDiag.Text:=DataModuleHM.AsaStoredProcShowInsurCaseMKBDiagNum.AsString;
   DataModuleHM.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleHM.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleHM.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
   if (InsurCaseNum=-1) then
    begin
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(0));
      FillComboBranch(0);
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(0));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(0));
      ComboBoxBranch.ItemIndex:=ComboBoxBranch.Items.IndexOfObject(TObject(0));

      BitBtnPrint.Enabled:=False;
      ButtonAdd.Enabled:=False;
      ButtonDel.Enabled:=False;
      DateEditBegin.Date:=Now();
      Limit:=0;
      LimitMed := 0;
      LimitServ := 0;
    end
   else
    begin
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseHospitalNum.AsInteger));
      FillComboBranch(DataModuleHM.AsaStoredProcShowInsurCaseHospitalNum.AsInteger);
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseTreatNum.AsInteger));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseIllNum.AsInteger));
      ComboBoxBranch.ItemIndex:=ComboBoxBranch.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseBranchNum.AsInteger));

      BitBtnPrint.Enabled:=True;
      ButtonAdd.Enabled:=True;
      ButtonDel.Enabled:=True;
      GetLimit;
    end;

   BedDay:=DataModuleHM.AsaStoredProcShowInsurCaseMedBedDay.Value;

   if BedDay=0 then
     begin
       CurrencyEditTariff.Visible:=False;
       CurrencyEditSum.Value:=DataModuleHM.AsaStoredProcShowInsurCaseMedTariff.Value;
       RadioGroupIsTariff.ItemIndex:=0;
     end
   else
     begin
       CurrencyEditTariff.Visible:=True;
       CurrencyEditTariff.Value:=BedDay;
       RadioGroupIsTariff.ItemIndex:=1;
     end;

   CurrencyEditDiag.Value:=DataModuleHM.AsaStoredProcShowInsurCaseDiagSum.Value;
//   CurrencyEditTotal.Value:=DataModuleHM.AsaStoredProcShowInsurCaseTotalSum.Value;
   CurrencyEditRest.Value:=Limit-CurrencyEditTotal.Value;
   Close;
  end;    // with

  DataModuleHM.AsaStoredProcListMedic.Close;
  DataModuleHM.AsaStoredProcListMedic.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
  DataModuleHM.AsaStoredProcListMedic.Open;

  ReCalc(Sender);
  MaskEditMKBDiag.SetFocus;
  BitBtnCancel.Enabled:=True;
end;

procedure TInsNewMedForm.BitBtnCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TInsNewMedForm.BitBtnSaveClick(Sender: TObject);
var
  FirstInsur:Boolean;
  I: Integer;
begin
 FirstInsur:=InsurCaseNum=-1;
 ReCalc(Sender);
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
     ParamByName('@BranchNum').AsInteger:=Integer(ComboBoxBranch.Items.Objects[ComboBoxBranch.ItemIndex]);
     ParamByName('@IllNum').AsInteger:=Integer(ComboBoxIll.Items.Objects[ComboBoxIll.ItemIndex]);
     ParamByName('@TreatNum').AsInteger:=Integer(ComboBoxTreat.Items.Objects[ComboBoxTreat.ItemIndex]);


     if DateEditBegin.Date<>0 then
       ParamByName('@BeginDate').AsDate:=DateEditBegin.Date
     else
       ParamByName('@BeginDate').Clear;
     if DateEditEnd.Date<>0 then
       ParamByName('@EndDate').AsDate:=DateEditEnd.Date
     else
       ParamByName('@EndDate').Clear;

     if DateEditDoc.Date<>0 then
       ParamByName('@DocDate').AsDate:=DateEditDoc.Date
     else
       ParamByName('@DocDate').Clear;

     if DateEditProtocol.Date<>0 then
       ParamByName('@ReportDate').AsDate:=DateEditProtocol.Date
     else
       ParamByName('@ReportDate').Clear;

     ParamByName('@Comment').AsString:=MemoComment.Text;
     ParamByName('@IsIndust').AsBoolean:=CheckBoxIndust.Checked;

     ParamByName('@MedSum').AsCurrency:=CurrencyEditMedical.Value; // Сумма по медикаментам
     ParamByName('@DiagSum').AsCurrency:=CurrencyEditDiag.Value; // Сумма за обследование

     if RadioGroupIsTariff.ItemIndex=0 then
       begin
         ParamByName('@MedTariff').AsCurrency:=CurrencyEditSum.Value;
         ParamByName('@MedBedDay').Clear;
       end
     else
       begin
         ParamByName('@MedTariff').Clear;
         ParamByName('@MedBedDay').AsCurrency:=CurrencyEditTariff.Value;
       end;

     ParamByName('@Akt').AsString:=EditAkt.Text;

     if DateEditAktDate.Date<>0 then
       ParamByName('@AktDate').AsDate:=DateEditAktDate.Date
     else
       ParamByName('@AktDate').Clear;

     ParamByName('@AddAkt').AsBoolean:=CheckBoxAddAkt.Checked;
     ParamByName('@AddMedSum').AsCurrency:=CurrencyEditFood.Value;
     ParamByName('@TypeInsurCase').AsInteger:=0;
     ParamByName('@PayPercent').AsInteger:=Round(CurrencyEditPayPercent.Value);
     ParamByName('@TotalSum').AsCurrency:=CurrencyEditTotal.Value; // Общая сумма

     ExecProc;
     InsurCaseNum:=ParamByName('@InsurCaseNum').AsInteger;
     DataModuleHM.AsaSessionHM.Commit;

     if FirstInsur then
      begin
       if (MessageDlg('Будем выдавать мед-ты?',mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
         begin
          ButtonAdd.Enabled:=True;
          ButtonDel.Enabled:=True;
          BitBtnPrint.Enabled:=True;
          ButtonAddClick(Sender);
         end
       else
         InsNewMedForm.Close;
      end
     else
       InsNewMedForm.Close;
 end;    // with
 except
   on e: Exception do
    begin
     DataModuleHM.AsaSessionHM.Rollback;
     ShowMessage('Ошибка сохранения '+e.Message);
    end;
 end;    // try/except
end;

procedure TInsNewMedForm.FillComboHospital;
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

procedure TInsNewMedForm.FillComboBranch(hn:Integer);
begin
 ComboBoxBranch.Items.Clear;
 with DataModuleHM.AsaStoredProcListBranch do
 begin
   ParamByName('@HospitalNum').AsInteger:=hn;
   Open;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxBranch.Items.AddObject(DataModuleHM.AsaStoredProcListBranchBranchName.AsString,TObject(DataModuleHM.AsaStoredProcListBranchBranchNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;

procedure TInsNewMedForm.FillComboIll;
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

procedure TInsNewMedForm.FillComboTreat;
begin
 with DataModuleHM.AsaStoredProcListTreatment do
 begin
   ParamByName('@MaxInsurNum').Value:=InsurNum;
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


procedure TInsNewMedForm.FormCreate(Sender: TObject);
begin
   FillComboHospital;
   FillComboIll;
end;

procedure TInsNewMedForm.BitBtnPrintClick(Sender: TObject);
begin
  ReportModuleHM.PrintInsurCase(InsurCaseNum);
end;


procedure TInsNewMedForm.MaskEditMKBDiagChange(Sender: TObject);
begin
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
   DataModuleHM.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleHM.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleHM.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
end;

procedure TInsNewMedForm.MaskEditMKBDiagKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key=VK_F1) then
  begin
   ListMKBDiagForm.ShowModal;
   MaskEditMKBDiag.Text:=DataModuleHM.AsaStoredProcListMKBDiagMKBDiagNum.Value;
   MaskEditMKBDiagChange(Sender);
  end;
end;

procedure TInsNewMedForm.ButtonEditHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewMedForm.ButtonInsHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=-1;
  ShowModal;
 end;    // with
end;

procedure TInsNewMedForm.MaskEditMKBDiagEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000409', KLF_ACTIVATE); // английский
end;

procedure TInsNewMedForm.MemoCommentEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

procedure TInsNewMedForm.ButtonEditBranchClick(Sender: TObject);
begin
 with BranchForm do
 begin
  HospitalNum:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
  BranchNum:=Integer(ComboBoxBranch.Items.Objects[ComboBoxBranch.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewMedForm.ButtonAddBranchClick(Sender: TObject);
begin
 with BranchForm do
 begin
  HospitalNum:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
  BranchNum:=-1;
  ShowModal;
 end;    // with
end;

procedure TInsNewMedForm.ComboBoxHospitalChange(Sender: TObject);
begin
  FillComboBranch(Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]));
  if ComboBoxBranch.Items.Count>0 then
   begin
     ComboBoxBranch.ItemIndex:=0;
     ComboBoxBranchChange(Sender);
   end;
end;

procedure TInsNewMedForm.Recalc(Sender: TObject);
var EndDate:TDateTime;
    md:Currency;
begin
  if DateEditEnd.date<>0 then
    EndDate:=DateEditEnd.date
  else
    EndDate:=Date();

  if RadioGroupIsTariff.ItemIndex=0 then
    begin
      CurrencyEditTariff.Visible:=False;
      CurrencyEditSum.ReadOnly:=False;
    end
  else
    begin
      CurrencyEditTariff.Visible:=True;
      CurrencyEditTariff.Value:=BedDay;
      CurrencyEditSum.ReadOnly:=True;
      CurrencyEditSum.Value:=(EndDate-DateEditBegin.Date)*BedDay;
    end;

    md:=0;
    try
      // statements to try
      md:=StrToFloat(DBGridEhMedic.GetFooterValue(0,DBGridEhMedic.Columns[5]));
    except
    end;    // try/except

    CurrencyEditTotal.Value:=CurrencyEditSum.Value+CurrencyEditDiag.Value+CurrencyEditMedical.Value+ CurrencyEditFood.Value +md;
    if (Limit <> 0) or ((LimitServ=0) and (LimitMed = 0)) then
    begin
      DBGridEhMedic.Columns[6].Footer.Value := '';
      CurrencyEditRest.Value:=Limit-CurrencyEditTotal.Value;
    end
    else
    begin
      DBGridEhMedic.Columns[6].Footer.Value := Format('%m',[(LimitMed - md)]);
      CurrencyEditRest.Value:=LimitServ-CurrencyEditTotal.Value+md;
    end;
end;

procedure TInsNewMedForm.CurrencyEditLimitChange(Sender: TObject);
begin
  GetLimit;
  CurrencyEditRest.Value:=Limit-CurrencyEditTotal.Value;
end;

procedure TInsNewMedForm.ComboBoxBranchChange(Sender: TObject);
begin
  GetBedDay;
  ReCalc(Sender);
end;

procedure TInsNewMedForm.CheckBoxAddAktClick(Sender: TObject);
begin
{
  CurrencyEditAddAktSum.Enabled:=CheckBoxAddAkt.Checked;
  if not CheckBoxAddAkt.Checked then
    CurrencyEditAddAktSum.Value:=0
  else
    CurrencyEditAddAktSum.SetFocus;
}
end;

procedure TInsNewMedForm.GetBedDay;
begin
  with DataModuleHM.AsaStoredProcShowBranch do
  begin
    ParamByName('@BranchNum').AsInteger:=Integer(ComboBoxBranch.Items.Objects[ComboBoxBranch.ItemIndex]);
    Open;
    if Integer(ComboBoxTreat.Items.Objects[ComboBoxTreat.ItemIndex])=1 then
      BedDay:=DataModuleHM.AsaStoredProcShowBranchBedDay1.Value
    else
    if Integer(ComboBoxTreat.Items.Objects[ComboBoxTreat.ItemIndex])=2 then
      BedDay:=DataModuleHM.AsaStoredProcShowBranchBedDay2.Value
    else
      BedDay:=0;
    Close;
  end;    // with
end;

procedure TInsNewMedForm.GetLimit;
var tr:Integer;
begin
  tr:=Integer(ComboBoxTreat.Items.Objects[ComboBoxTreat.ItemIndex]);
  with DataModuleHM.AsaStoredProcGetLimit do
  begin
    ParamByName('@MaxInsurNum').AsInteger:=InsurNum;
    ParamByName('@TreatNum').AsInteger:=tr;
    Open;
    Limit := DataModuleHM.AsaStoredProcGetLimitLimit.Value;
    LimitMed := DataModuleHM.AsaStoredProcGetLimitMedLimit.Value;
    LimitServ := DataModuleHM.AsaStoredProcGetLimitServLimit.Value;
    Close;
  end;    // with
  with DataModuleHM.AsaStoredProcGetSumTotalSum do
  begin
    ParamByName('@ClientID').AsInteger:=ClientID;
    ParamByName('@InsurNum').AsInteger:=InsurNum;
    ParamByName('@TreatNum').AsInteger:=tr;
    ParamByName('@InsurCaseNum').AsInteger:=InsurCaseNum;
    Open;
    Limit:=Limit-DataModuleHM.AsaStoredProcGetSumTotalSumTotalSum.Value;
    LimitMed := LimitMed - DataModuleHM.AsaStoredProcGetSumTotalSumMedSum.Value;
    LimitServ := LimitServ - DataModuleHM.AsaStoredProcGetSumTotalSumServSum.Value;
    Close;
  end;    // with

  if (Limit<>0) or ((LimitMed = 0) and (LimitServ = 0)) then
  begin
        EditLimit.Text:=FloatToStr(Limit);
        PanelLim.Visible := False;
  end
  else
  begin
        EditLimitMed.Text := FloatToStr(LimitMed);
        EditLimitServ.Text := FloatToStr(LimitServ);
        PanelLim.Visible := True;
  end

end;

procedure TInsNewMedForm.RadioGroupIsTariffClick(Sender: TObject);
begin
  GetBedDay;
  Recalc(Sender);
  CurrencyEditSum.Value:=0;
  if RadioGroupIsTariff.ItemIndex=0 then
    CurrencyEditSum.SetFocus
  else
    CurrencyEditTariff.SetFocus;
end;

procedure TInsNewMedForm.ComboBoxTreatChange(Sender: TObject);
begin
  GetLimit;
  CurrencyEditRest.Value:=Limit-CurrencyEditTotal.Value;
  GetBedDay;
  Recalc(Sender);
end;

procedure TInsNewMedForm.ButtonAddClick(Sender: TObject);
var mb, me: Currency;
begin
  mb:=0;
  me:=0;
  try
    mb:=StrToFloat(DBGridEhMedic.GetFooterValue(0,DBGridEhMedic.Columns[5]));
  except
  end;    // try/except
  InsFinForm.InsurCaseNum:=InsurCaseNum;
  InsFinForm.ShowModal;
  DataModuleHM.AsaStoredProcListMedic.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
  RefreshQuery(DataModuleHM.AsaStoredProcListMedic);
  ReCalc(Sender);
  try
    me:=StrToFloat(DBGridEhMedic.GetFooterValue(0,DBGridEhMedic.Columns[5]));
  except
  end;    // try/except
  if mb<>me then
        BitBtnCancel.Enabled:=False;
end;

procedure TInsNewMedForm.ButtonDelClick(Sender: TObject);
var mb, me: Currency;
begin
{
  if DataModuleHM.AsaStoredProcListMedicFinance.Value<0 then
    begin
      ShowMessage('Нельзя делать откат на откат');
      Exit;
    end;
 }
  mb:=0;
  me:=0;
  try
    mb:=StrToFloat(DBGridEhMedic.GetFooterValue(0,DBGridEhMedic.Columns[5]));
  except
  end;    // try/except

  if MessageDlg('Вы уверены, что хотите сделать откат?',
    mtConfirmation, [mbYes,mbNo], 0) = mrNo then Exit;

  with DataModuleHM.AsaStoredProcUnMedic do
  begin
    ParamByName('@LocCode').Value:=DataModuleHM.LocCode;
    ParamByName('@MedicNum').Value:=DataModuleHM.AsaStoredProcListMedicMedicNum.Value;
    ExecProc;
  end;    // with
  RefreshQuery(DataModuleHM.AsaStoredProcListMedic);
  ReCalc(Sender);
  if mb<>me then
        BitBtnCancel.Enabled:=False;
end;

end.
