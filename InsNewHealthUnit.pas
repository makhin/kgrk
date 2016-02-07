unit InsNewHealthUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, Grids, DBGridEh, ExtCtrls, Buttons, RxLookup,
  DBCtrls, DBLookupEh, DBUtils, CurrEdit;

type
  TInsNewHealthForm = class(TForm)
    Label2: TLabel;
    ComboBoxTreat: TComboBox;
    Label3: TLabel;
    DateEditBegin: TDateEdit;
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
    RadioGroupIsTariff: TRadioGroup;
    Label10: TLabel;
    DateEditProtocol: TDateEdit;
    CurrencyEditSum: TCurrencyEdit;
    Label6: TLabel;
    DateEditDoc: TDateEdit;
    CheckBoxDeathType: TCheckBox;
    Panel2: TPanel;
    Panel1: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    CurrencyEditDR: TCurrencyEdit;
    CurrencyEditDS: TCurrencyEdit;
    CurrencyEditDA: TCurrencyEdit;
    PanelTariff: TPanel;
    Label5: TLabel;
    Label13: TLabel;
    CurrencyEditCalcSum: TCurrencyEdit;
    CurrencyEditTA: TCurrencyEdit;
    CurrencyEditTS: TCurrencyEdit;
    CurrencyEditTR: TCurrencyEdit;
    CurrencyEditSA: TCurrencyEdit;
    CurrencyEditSS: TCurrencyEdit;
    CurrencyEditSR: TCurrencyEdit;
    Label14: TLabel;
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
    procedure RadioGroupIsTariffClick(Sender: TObject);
    procedure CurrencyEditDAChange(Sender: TObject);
    procedure CurrencyEditDSChange(Sender: TObject);
    procedure CurrencyEditDRChange(Sender: TObject);
    procedure CurrencyEditSAChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InsurCaseNum:integer;
    ClientID:Integer;
    InsurNum:Integer;
    FactoryNum:Integer;
    TypeInsurCase:Integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure FillComboHospital;
    procedure FillComboTreat;
    procedure FillComboIll;

  end;

var
  InsNewHealthForm: TInsNewHealthForm;

implementation

uses DataUnit, ReportUnit, MainFormUnit, HospitalUnit, ListMKBUnit,
  BranchUnit;
{$R *.DFM}

procedure TInsNewHealthForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TInsNewHealthForm.FormActivate(Sender: TObject);
begin
 FillComboTreat;
 with DataModuleHM.AsaStoredProcShowInsurCase do
 begin
   Close;
   ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
   Open;
   DateEditProtocol.Date:=DataModuleHM.AsaStoredProcShowInsurCaseReportDate.Value;
   DateEditDoc.Date:=DataModuleHM.AsaStoredProcShowInsurCaseDocDate.Value;
   DateEditBegin.Date:=DataModuleHM.AsaStoredProcShowInsurCaseBeginDate.AsDateTime;
   DateEditEnd.Date:=DataModuleHM.AsaStoredProcShowInsurCaseEndDate.AsDateTime;
   MemoComment.Text:=DataModuleHM.AsaStoredProcShowInsurCaseComment.AsString;
   CheckBoxDeathType.Checked:=DataModuleHM.AsaStoredProcShowInsurCaseDeathType.Value;

   CurrencyEditSum.Value:=DataModuleHM.AsaStoredProcShowInsurCaseHealthSum.Value;

   CurrencyEditDA.Value:=DataModuleHM.AsaStoredProcShowInsurCaseDay_Amb.Value;
   CurrencyEditDS.Value:=DataModuleHM.AsaStoredProcShowInsurCaseDay_Stac.Value;
   CurrencyEditDR.Value:=DataModuleHM.AsaStoredProcShowInsurCaseDay_Reanim.Value;

   CurrencyEditTA.Value:=DataModuleHM.AsaStoredProcShowInsurCaseTarif_Amb.Value;
   CurrencyEditTS.Value:=DataModuleHM.AsaStoredProcShowInsurCaseTarif_Stac.Value;
   CurrencyEditTR.Value:=DataModuleHM.AsaStoredProcShowInsurCaseTarif_Reanim.Value;

   if CurrencyEditSum.Value>0 then
     begin
       RadioGroupIsTariff.ItemIndex:=1;
       PanelTariff.Visible:=False;
       CurrencyEditCalcSum.Visible:=False;
       CurrencyEditSum.Visible:=True;
     end
   else
     begin
       RadioGroupIsTariff.ItemIndex:=0;
       PanelTariff.Visible:=True;
       CurrencyEditCalcSum.Visible:=True;
       CurrencyEditSum.Visible:=False;
     end;
   MaskEditMKBDiag.Text:=DataModuleHM.AsaStoredProcShowInsurCaseMKBDiagNum.AsString;
   DataModuleHM.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleHM.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleHM.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
   if (InsurCaseNum=-1) then
    begin
      RadioGroupIsTariff.ItemIndex:=1;
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(0));
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(0));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(0));
      BitBtnPrint.Enabled:=False;
      DateEditBegin.Date:=Now();
    end
   else
    begin
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseHospitalNum.AsInteger));
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseTreatNum.AsInteger));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseIllNum.AsInteger));
      BitBtnPrint.Enabled:=True;
    end;
   Close;
 end;    // with
  MaskEditMKBDiag.SetFocus;
end;

procedure TInsNewHealthForm.BitBtnCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TInsNewHealthForm.BitBtnSaveClick(Sender: TObject);
var
  I: Integer;
begin
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

     if DateEditBegin.Date<>0 then
       ParamByName('@BeginDate').AsDate:=DateEditBegin.Date
     else
       ParamByName('@BeginDate').Clear;

     if DateEditEnd.Date<>0 then
       ParamByName('@EndDate').AsDate:=DateEditEnd.Date
     else
       ParamByName('@EndDate').Clear;

     if DateEditProtocol.Date<>0 then
       ParamByName('@ReportDate').AsDate:=DateEditProtocol.Date
     else
       ParamByName('@ReportDate').Clear;

     if DateEditDoc.Date<>0 then
       ParamByName('@DocDate').AsDate:=DateEditDoc.Date
     else
       ParamByName('@DocDate').Clear;

     ParamByName('@DeathType').AsBoolean:=CheckBoxDeathType.Checked;
     ParamByName('@Comment').AsString:=MemoComment.Text;

     ParamByName('@Day_Amb').AsInteger:=Round(CurrencyEditDA.Value);
     ParamByName('@Day_Stac').AsInteger:=Round(CurrencyEditDS.Value);
     ParamByName('@Day_Reanim').AsInteger:=Round(CurrencyEditDR.Value);


     if RadioGroupIsTariff.ItemIndex=1 then
       begin
         ParamByName('@HealthSum').AsCurrency:=CurrencyEditSum.Value;
         ParamByName('@TotalSum').AsCurrency:=CurrencyEditSum.Value;
         ParamByName('@HealthTariff').Clear;
         ParamByName('@Tarif_Amb').Clear;
         ParamByName('@Tarif_Stac').Clear;
         ParamByName('@Tarif_Reanim').Clear;
       end
     else
       begin
         ParamByName('@HealthSum').Clear;

         ParamByName('@Tarif_Amb').AsCurrency:=Round(CurrencyEditTA.Value);
         ParamByName('@Tarif_Stac').AsCurrency:=Round(CurrencyEditTS.Value);
         ParamByName('@Tarif_Reanim').AsCurrency:=Round(CurrencyEditTR.Value);

         ParamByName('@TotalSum').AsCurrency:=CurrencyEditCalcSum.Value;
       end;

     ParamByName('@TypeInsurCase').AsInteger:=TypeInsurCase;

     ExecProc;
     InsurCaseNum:=ParamByName('@InsurCaseNum').AsInteger;
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

procedure TInsNewHealthForm.FillComboHospital;
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

procedure TInsNewHealthForm.FillComboIll;
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

procedure TInsNewHealthForm.FillComboTreat;
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


procedure TInsNewHealthForm.FormCreate(Sender: TObject);
begin
   FillComboHospital;
   FillComboIll;
end;

procedure TInsNewHealthForm.BitBtnPrintClick(Sender: TObject);
begin
  ReportModuleHM.PrintInsurCase(InsurCaseNum);
end;


procedure TInsNewHealthForm.MaskEditMKBDiagChange(Sender: TObject);
begin
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
   DataModuleHM.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleHM.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleHM.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
end;

procedure TInsNewHealthForm.MaskEditMKBDiagKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key=VK_F1) then
  begin
   ListMKBDiagForm.ShowModal;
   MaskEditMKBDiag.Text:=DataModuleHM.AsaStoredProcListMKBDiagMKBDiagNum.Value;
   MaskEditMKBDiagChange(Sender);
  end;
end;

procedure TInsNewHealthForm.ButtonEditHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewHealthForm.ButtonInsHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=-1;
  ShowModal;
 end;    // with
end;

procedure TInsNewHealthForm.MaskEditMKBDiagEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000409', KLF_ACTIVATE); // английский
end;

procedure TInsNewHealthForm.MemoCommentEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

procedure TInsNewHealthForm.RadioGroupIsTariffClick(Sender: TObject);
begin
if RadioGroupIsTariff.ItemIndex=1 then
  begin
    PanelTariff.Visible:=False;



    CurrencyEditCalcSum.Visible:=False;
    CurrencyEditSum.Visible:=True;
    CurrencyEditCalcSum.Value:=0;
  end
else
  begin
    PanelTariff.Visible:=True;



    CurrencyEditCalcSum.Visible:=True;
    CurrencyEditSum.Visible:=False;
    CurrencyEditSum.Value:=0;
  end;

end;

procedure TInsNewHealthForm.CurrencyEditDAChange(Sender: TObject);
begin
  CurrencyEditSA.Value:=CurrencyEditDA.Value  * CurrencyEditTA.Value;
end;

procedure TInsNewHealthForm.CurrencyEditDSChange(Sender: TObject);
begin
  CurrencyEditSS.Value:=CurrencyEditDS.Value  * CurrencyEditTS.Value;
end;

procedure TInsNewHealthForm.CurrencyEditDRChange(Sender: TObject);
begin
  CurrencyEditSR.Value:=CurrencyEditDR.Value  * CurrencyEditTR.Value;
end;

procedure TInsNewHealthForm.CurrencyEditSAChange(Sender: TObject);
begin
 CurrencyEditCalcSum.value:=CurrencyEditSA.Value+CurrencyEditSS.Value+CurrencyEditSR.Value;
end;

end.
