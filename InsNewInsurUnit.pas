unit InsNewInsurUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, Grids, DBGridEh, ExtCtrls, Buttons, RxLookup,
  DBCtrls, DBLookupEh, DBUtils, CurrEdit;

type
  TInsNewInsurForm = class(TForm)
    Label2: TLabel;
    ComboBoxTreat: TComboBox;
    Label3: TLabel;
    DateEditBegin: TDateEdit;
    DateEditEnd: TDateEdit;
    Label4: TLabel;
    Panel: TPanel;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    PanelMid: TPanel;
    DBGridEhOrder: TDBGridEh;
    BitBtnPrint: TBitBtn;
    Label11: TLabel;
    EditSickList: TEdit;
    ButtonNewOrder: TButton;
    ButtonUnOrder: TButton;
    ButtonPrintOrder: TButton;
    Label1: TLabel;
    MaskEditMKBDiag: TMaskEdit;
    ComboBoxIll: TComboBox;
    ComboBoxHospital: TComboBox;
    ButtonInsHospital: TButton;
    Label5: TLabel;
    MemoComment: TMemo;
    Label12: TLabel;
    MemoMKBDiagName: TMemo;
    ButtonEditHospital: TButton;
    ButtonEdit: TButton;
    GroupBoxProg: TGroupBox;
    Label7: TLabel;
    Label13: TLabel;
    CurrencyEditProgRest: TCurrencyEdit;
    CurrencyEditProgLimit: TCurrencyEdit;
    GroupBoxInsurCase: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    CurrencyEditCaseRest: TCurrencyEdit;
    CurrencyEditCaseLimit: TCurrencyEdit;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ButtonNewOrderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonUnOrderClick(Sender: TObject);
    procedure ButtonPrintOrderClick(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure MaskEditMKBDiagChange(Sender: TObject);
    procedure MaskEditMKBDiagKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonEditHospitalClick(Sender: TObject);
    procedure ButtonInsHospitalClick(Sender: TObject);
    procedure MaskEditMKBDiagEnter(Sender: TObject);
    procedure MemoCommentEnter(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure DBGridEhOrderGetCellParams(Sender: TObject;
      Column: TColumnEh; AFont: TFont; var Background: TColor;
      State: TGridDrawState);
    procedure ReCalc(Sender: TObject);
    procedure ComboBoxTreatChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InsurCaseNum:integer;
    ClientID:Integer;
    InsurNum:Integer;
    FactoryNum:Integer;
    TypeInsurCase:Integer;
    GlobalLimit, LocalLimit :Currency;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure FillComboHospital;
    procedure FillComboTreat;
    procedure FillComboIll;
    //procedure RefrLabel;
    procedure GetLimit;
  end;

var
  InsNewInsurForm: TInsNewInsurForm;

implementation

uses DataUnit, InsNewOrderUnit, ReportUnit, MainFormUnit, ListMKBUnit,
HospitalUnit;
{$R *.DFM}

procedure TInsNewInsurForm.CMDialogKey(var Message: TCMDialogKey);
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


procedure TInsNewInsurForm.FormActivate(Sender: TObject);
begin
 CurrencyString:='';
 FillComboTreat;
 with DataModuleHM.AsaStoredProcShowInsurCase do
 begin
   Close;
   ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
   Open;
   DateEditBegin.Date:=DataModuleHM.AsaStoredProcShowInsurCaseBeginDate.AsDateTime;
   DateEditEnd.Date:=DataModuleHM.AsaStoredProcShowInsurCaseEndDate.AsDateTime;
   MemoComment.Text:=DataModuleHM.AsaStoredProcShowInsurCaseComment.AsString;
   EditSickList.Text:=DataModuleHM.AsaStoredProcShowInsurCaseSickList.Value;
   MaskEditMKBDiag.Text:=DataModuleHM.AsaStoredProcShowInsurCaseMKBDiagNum.AsString;
   DataModuleHM.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleHM.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleHM.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
   if (InsurCaseNum=-1) then
    begin
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(DataModuleHM.NativeHospitalNum));
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(0));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(0));
      ButtonNewOrder.Enabled:=False;
      ButtonEdit.Enabled:=False;
      ButtonUnOrder.Enabled:=False;
      ButtonPrintOrder.Enabled:=False;
      BitBtnPrint.Enabled:=False;
      DateEditBegin.Date:=Now();
    end
   else
    begin
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseHospitalNum.AsInteger));
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseTreatNum.AsInteger));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcShowInsurCaseIllNum.AsInteger));
      ButtonNewOrder.Enabled:=True;
      ButtonEdit.Enabled:=True;
      ButtonUnOrder.Enabled:=True;
      ButtonPrintOrder.Enabled:=True;
      BitBtnPrint.Enabled:=True;
    end;
   Close;
 end;    // with
  GetLimit;
  ReCalc(Sender);
  DataModuleHM.AsaStoredProcListOrder_s.Close;
  DataModuleHM.AsaStoredProcListOrder_s.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
  DataModuleHM.AsaStoredProcListOrder_s.Open;
  if DataModuleHM.AsaStoredProcListOrder_s.RecordCount=0 then
    ButtonPrintOrder.Enabled:=False
  else
    ButtonPrintOrder.Enabled:=True;
  ReCalc(Sender);
  MaskEditMKBDiag.SetFocus;
end;

procedure TInsNewInsurForm.BitBtnCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TInsNewInsurForm.BitBtnSaveClick(Sender: TObject);
var FirstInsur:Boolean;
begin
 FirstInsur:=InsurCaseNum=-1;

 try
   // statements to try
 with DataModuleHM.AsaStoredProcRefrInsurCase do
 begin
//     if MainForm.NStart.Enabled then


     DataModuleHM.AsaSessionHM.StartTransaction;
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
     ParamByName('@SickList').AsString:=EditSickList.Text;
     ParamByName('@TotalSum').AsCurrency:=StrToFloat(DBGridEhOrder.GetFooterValue(0,DBGridEhOrder.Columns[2]));

     ParamByName('@TypeInsurCase').AsInteger:=TypeInsurCase;

     if DateEditBegin.Date<>0 then
       ParamByName('@BeginDate').AsDate:=DateEditBegin.Date
     else
       ParamByName('@BeginDate').Clear;
     if DateEditEnd.Date<>0 then
       ParamByName('@EndDate').AsDate:=DateEditEnd.Date
     else
       ParamByName('@EndDate').Clear;
     ParamByName('@Comment').AsString:=MemoComment.Text;

     if ParamByName('@TreatNum').AsString='' then
      raise Exception.Create('Не ввели тип лечения');

     ExecProc;
     InsurCaseNum:=ParamByName('@InsurCaseNum').AsInteger;
//     if MainForm.NStart.Enabled then
     DataModuleHM.AsaSessionHM.Commit;
      if FirstInsur then
       begin
         if (MessageDlg('Будем выдавать медикаменты?',mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
           begin
            ButtonNewOrder.Enabled:=True;
	    ButtonEdit.Enabled:=True;
            ButtonUnOrder.Enabled:=True;
            ButtonPrintOrder.Enabled:=True;
            BitBtnPrint.Enabled:=True;
            ButtonNewOrderClick(Sender);
           end
         else
           InsNewInsurForm.Close;
       end
      else
         InsNewInsurForm.Close;
 end;    // with
 except
   on e: Exception do
    begin
     DataModuleHM.AsaSessionHM.Rollback;
     ShowMessage('Ошибка сохранения '+e.Message);
    end;
 end;    // try/except
end;

procedure TInsNewInsurForm.FillComboHospital;
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

procedure TInsNewInsurForm.FillComboIll;
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

procedure TInsNewInsurForm.FillComboTreat;
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


procedure TInsNewInsurForm.FormDeactivate(Sender: TObject);
begin
  DataModuleHM.AsaStoredProcListOrder_s.Close;
end;

procedure TInsNewInsurForm.ButtonNewOrderClick(Sender: TObject);
begin
  InsOrderForm.InsurCaseNum:=InsurCaseNum;
  InsOrderForm.OrderNum:=0;
  InsOrderForm.ShowModal;
  DataModuleHM.AsaStoredProcListOrder_s.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
  RefreshQuery(DataModuleHM.AsaStoredProcListOrder_s);
  if DataModuleHM.AsaStoredProcListOrder_s.RecordCount=0 then
    ButtonPrintOrder.Enabled:=False
  else
    ButtonPrintOrder.Enabled:=True;
  ReCalc(Sender);
end;

procedure TInsNewInsurForm.FormCreate(Sender: TObject);
begin
   FillComboHospital;
   FillComboIll;
end;

procedure TInsNewInsurForm.ButtonUnOrderClick(Sender: TObject);
begin
  if DataModuleHM.AsaStoredProcListOrder_sTotalSale.Value < 0 then
  begin
    if MessageDlg('Это откат на откат?',
      mtConfirmation, [mbYes,mbNo], 0) = mrNo then Exit;
  end
  else
  begin
    if MessageDlg('Вы уверены, что хотите сделать откат?',
      mtConfirmation, [mbYes,mbNo], 0) = mrNo then Exit;
  end;

  with DataModuleHM.AsaStoredProcUnOrder do
  begin
    ParamByName('@LocCode').Value:=DataModuleHM.LocCode;
    ParamByName('@OrderNum').Value:=DataModuleHM.AsaStoredProcListOrder_sOrderNum.Value;
    ParamByName('@Operator').Value:=DataModuleHM.Operator;
    ExecProc;
  end;    // with
  RefreshQuery(DataModuleHM.AsaStoredProcListOrder_s);
  ReCalc(Sender);
end;

procedure TInsNewInsurForm.ButtonPrintOrderClick(Sender: TObject);
begin
  ReportModuleHM.PrintOrder(DataModuleHM.AsaStoredProcListOrder_sOrderNum.Value);
end;

procedure TInsNewInsurForm.BitBtnPrintClick(Sender: TObject);
begin
  ReportModuleHM.PrintInsurCase(InsurCaseNum);
end;

{
procedure TInsNewInsurForm.RefrLabel;
begin
 with DataModuleHM.AsaStoredProcShowInsurCase do
 begin
   ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
   Open;
   LabelTreatMoney.Caption:=DataModuleHM.AsaStoredProcShowInsurCaseTreatMoney.AsString;
   LabelSumOrder.Caption:=DataModuleHM.AsaStoredProcShowInsurCaseTotalSale.AsString;
   LabelDebt.Caption:=DataModuleHM.AsaStoredProcShowInsurCaseDebt.AsString;
   Close;
 end;    // with
end;
}

procedure TInsNewInsurForm.MaskEditMKBDiagChange(Sender: TObject);
begin
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
   DataModuleHM.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleHM.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleHM.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   DataModuleHM.AsaStoredProcShowMKBDiag.Close;
end;

procedure TInsNewInsurForm.MaskEditMKBDiagKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key=VK_F1) then
  begin
   ListMKBDiagForm.ShowModal;
   MaskEditMKBDiag.Text:=DataModuleHM.AsaStoredProcListMKBDiagMKBDiagNum.Value;
   MaskEditMKBDiagChange(Sender);
  end;
end;

procedure TInsNewInsurForm.ButtonEditHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewInsurForm.ButtonInsHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=-1;
  ShowModal;
 end;    // with
end;

procedure TInsNewInsurForm.MaskEditMKBDiagEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000409', KLF_ACTIVATE); // английский
end;

procedure TInsNewInsurForm.MemoCommentEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

procedure TInsNewInsurForm.ButtonEditClick(Sender: TObject);
begin
  if DataModuleHM.AsaStoredProcListOrder_sPaid.Value then
  begin
    ShowMessage('Нельзя редактировать закрытую накладную');
    exit;
  end;
  InsOrderForm.InsurCaseNum:=InsurCaseNum;
  InsOrderForm.OrderNum:=DataModuleHM.AsaStoredProcListOrder_sOrderNum.Value;
  InsOrderForm.ShowModal;
  DataModuleHM.AsaStoredProcListOrder_s.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
  ReCalc(Sender);
  RefreshQuery(DataModuleHM.AsaStoredProcListOrder_s);
  if DataModuleHM.AsaStoredProcListOrder_s.RecordCount=0 then
    ButtonPrintOrder.Enabled:=False
  else
    ButtonPrintOrder.Enabled:=True;

end;

procedure TInsNewInsurForm.DBGridEhOrderGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
 if not DataModuleHM.AsaStoredProcListOrder_sPaid.Value then
        AFont.Color:=clRed
 else
        AFont.Color:=clNavy;
end;

procedure TInsNewInsurForm.GetLimit;
var tr:Integer;
begin
  tr:=Integer(ComboBoxTreat.Items.Objects[ComboBoxTreat.ItemIndex]);
  with DataModuleHM.AsaStoredProcGetSumTotalSum do
  begin
    ParamByName('@ClientID').AsInteger:=ClientID;
    ParamByName('@InsurNum').AsInteger:=InsurNum;
    ParamByName('@TreatNum').AsInteger:=tr;
    ParamByName('@InsurCaseNum').AsInteger:=InsurCaseNum;
    Open;
    GroupBoxProg.Caption := DataModuleHM.AsaStoredProcGetSumTotalSumProgName.Value;
    GlobalLimit:=DataModuleHM.AsaStoredProcGetSumTotalSumLimit.Value-DataModuleHM.AsaStoredProcGetSumTotalSumTotalSum.Value;
    if (not DataModuleHM.AsaStoredProcGetSumTotalSumTreatLimit.IsNull) then
        LocalLimit:=DataModuleHM.AsaStoredProcGetSumTotalSumTreatLimit.Value
    else
        LocalLimit:=0;
    Close;
  end;    // with

  CurrencyEditProgLimit.Value := GlobalLimit;

  if (LocalLimit = 0) then
  begin
        GroupBoxInsurCase.Visible := False;
  end
  else
  begin
        GroupBoxInsurCase.Visible := True;
        CurrencyEditCaseLimit.Value :=LocalLimit;
  end

end;

procedure TInsNewInsurForm.Recalc(Sender: TObject);
var md:Currency;
begin
    md:=0;
    try
      // statements to try
      md:=StrToFloat(DBGridEhOrder.GetFooterValue(0,DBGridEhOrder.Columns[2]));
    except
    end;    // try/except

    CurrencyEditProgRest.Value := CurrencyEditProgLimit.Value - md;
    CurrencyEditCaseRest.Value := CurrencyEditCaseLimit.Value - md;
end;

procedure TInsNewInsurForm.ComboBoxTreatChange(Sender: TObject);
begin
  GetLimit;
  Recalc(Sender);
end;

end.
