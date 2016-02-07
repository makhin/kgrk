unit InsNewOtherLPUUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, Grids, DBGridEh, ExtCtrls, Buttons, RxLookup,
  DBCtrls, DBLookupEh, DBUtils, CurrEdit;

type
  TInsNewOtherLPUForm = class(TForm)
    Label3: TLabel;
    DateEditBegin: TDateEdit;
    DateEditEnd: TDateEdit;
    Label4: TLabel;
    PanelMid: TPanel;
    DBGridEhOrder: TDBGridEh;
    Label11: TLabel;
    EditSickList: TEdit;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    ButtonNewOrder: TButton;
    ButtonUnOrder: TButton;
    Label2: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    ComboBoxDiag: TComboBox;
    ComboBoxTreat: TComboBox;
    ButtonInsDiag: TButton;
    MaskEditMKBDiag: TMaskEdit;
    ComboBoxIll: TComboBox;
    ComboBoxHospital: TComboBox;
    ComboBoxDoctor: TComboBox;
    ButtonInsHospital: TButton;
    ButtonInsDoctor: TButton;
    MemoMKBDiagName: TMemo;
    ButtonEditDiag: TButton;
    ButtonEditHospital: TButton;
    ButtonEditDoctor: TButton;
    EditComment: TEdit;
    Label5: TLabel;
    DateEditDoc: TDateEdit;
    Label6: TLabel;
    RxCalcEditPayPercent: TRxCalcEdit;
    Label8: TLabel;
    Label10: TLabel;
    EditAkt: TEdit;
    DateEditReestr: TDateEdit;
    RxCalcEditAktSum: TRxCalcEdit;
    Label9: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ComboBoxBranch: TComboBox;
    ButtonInsBranch: TButton;
    ButtonEditBranch: TButton;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ButtonNewOrderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonUnOrderClick(Sender: TObject);
    procedure MaskEditMKBDiagChange(Sender: TObject);
    procedure MaskEditMKBDiagKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonEditDiagClick(Sender: TObject);
    procedure ButtonInsDiagClick(Sender: TObject);
    procedure ButtonEditHospitalClick(Sender: TObject);
    procedure ButtonInsHospitalClick(Sender: TObject);
    procedure ButtonEditDoctorClick(Sender: TObject);
    procedure ButtonInsDoctorClick(Sender: TObject);
    procedure MaskEditMKBDiagEnter(Sender: TObject);
    procedure EditCommentEnter(Sender: TObject);
    procedure ComboBoxHospitalChange(Sender: TObject);
    procedure ButtonEditBranchClick(Sender: TObject);
    procedure ButtonInsBranchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InsurCaseNum:integer;
    ClientNum:string;
    InsurNum:Integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure FillComboDiag(MKBDiag:string);
    procedure FillComboTreat;
    procedure FillComboDoctor;
    procedure FillComboBranch;
    procedure FillComboIll;
    procedure FillComboHospital;
  end;
var
  InsNewOtherLPUForm: TInsNewOtherLPUForm;

implementation

uses DataUnit, DiagnosisUnit, MainFormUnit, InsNewFinUnit, InsNewInsurUnit,
  ListDiagUnit, HospitalUnit, DoctorUnit, BranchUnit;
{$R *.DFM}

procedure TInsNewOtherLPUForm.CMDialogKey(var Message: TCMDialogKey);
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


procedure TInsNewOtherLPUForm.FormActivate(Sender: TObject);
begin
 FillComboDoctor;
 with DataModuleDMK.AsaStoredProcShowOtherLPU do
 begin
   Close;
   ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
   Open;
   DateEditBegin.Date:=DataModuleDMK.AsaStoredProcShowOtherLPUBeginDate.AsDateTime;
   DateEditEnd.Date:=DataModuleDMK.AsaStoredProcShowOtherLPUEndDate.AsDateTime;
   DateEditDoc.date:=DataModuleDMK.AsaStoredProcShowOtherLPUDocDate.AsDateTime;
   DateEditReestr.date:=DataModuleDMK.AsaStoredProcShowOtherLPUReestrDate.AsDateTime;
   RxCalcEditPayPercent.Value:=DataModuleDMK.AsaStoredProcShowOtherLPUPayPercent.Value;
   RxCalcEditAktSum.Value:=DataModuleDMK.AsaStoredProcShowOtherLPUAktSum.Value;
   EditAkt.Text:=DataModuleDMK.AsaStoredProcShowOtherLPUAkt.AsString;
   EditComment.Text:=DataModuleDMK.AsaStoredProcShowOtherLPUComment.AsString;
   EditSickList.Text:=DataModuleDMK.AsaStoredProcShowOtherLPUSickList.Value;
   MaskEditMKBDiag.Text:=DataModuleDMK.AsaStoredProcShowOtherLPUMKBDiagNum.AsString;
   FillComboDiag(DataModuleDMK.AsaStoredProcShowOtherLPUMKBDiagNum.AsString);
   DataModuleDMK.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleDMK.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleDMK.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   DataModuleDMK.AsaStoredProcShowMKBDiag.Close;
   if (InsurCaseNum=-1) then
    begin
      ComboBoxDiag.ItemIndex:=ComboBoxDiag.Items.IndexOfObject(TObject(0));
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(516));
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(0));
      ComboBoxDoctor.ItemIndex:=ComboBoxDoctor.Items.IndexOfObject(TObject(0));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(0));
      ComboBoxBranch.ItemIndex:=ComboBoxBranch.Items.IndexOfObject(TObject(0));
      RxCalcEditPayPercent.Value:=15;
      ButtonNewOrder.Enabled:=False;
      ButtonUnOrder.Enabled:=False;
      DateEditBegin.Date:=Now();
    end
   else
    begin
      if ComboBoxDiag.Items.IndexOfObject(TObject(DataModuleDMK.AsaStoredProcShowOtherLPUDiagNum.AsInteger))=-1 then
        ComboBoxDiag.ItemIndex:=ComboBoxDiag.Items.IndexOfObject(TObject(0))
      else
        ComboBoxDiag.ItemIndex:=ComboBoxDiag.Items.IndexOfObject(TObject(DataModuleDMK.AsaStoredProcShowOtherLPUDiagNum.AsInteger));
      ComboBoxHospital.ItemIndex:=ComboBoxHospital.Items.IndexOfObject(TObject(DataModuleDMK.AsaStoredProcShowOtherLPUHospitalNum.AsInteger));
      ComboBoxTreat.ItemIndex:=ComboBoxTreat.Items.IndexOfObject(TObject(DataModuleDMK.AsaStoredProcShowOtherLPUTreatNum.AsInteger));
      ComboBoxDoctor.ItemIndex:=ComboBoxDoctor.Items.IndexOfObject(TObject(DataModuleDMK.AsaStoredProcShowOtherLPUDoctorNum.AsInteger));
      ComboBoxIll.ItemIndex:=ComboBoxIll.Items.IndexOfObject(TObject(DataModuleDMK.AsaStoredProcShowOtherLPUIllNum.AsInteger));
      ComboBoxBranch.ItemIndex:=ComboBoxBranch.Items.IndexOfObject(TObject(DataModuleDMK.AsaStoredProcShowOtherLPUBranchNum.AsInteger));
      ButtonNewOrder.Enabled:=True;
      ButtonUnOrder.Enabled:=True;
    end;
   Close;
 end;    // with
  DataModuleDMK.AsaStoredProcListFinOtherLPU.Close;
  DataModuleDMK.AsaStoredProcListFinOtherLPU.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
  DataModuleDMK.AsaStoredProcListFinOtherLPU.Open;
  MaskEditMKBDiag.SetFocus;
end;

procedure TInsNewOtherLPUForm.BitBtnCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TInsNewOtherLPUForm.BitBtnSaveClick(Sender: TObject);
var FirstInsur:Boolean;
begin
 FirstInsur:=InsurCaseNum=-1;
 try
   // statements to try
 with DataModuleDMK.AsaStoredProcRefrOtherLPU do
 begin
     if MainForm.NStart.Enabled then
      DataModuleDMK.AsaSessionDMK.StartTransaction;
     ParamByName('@LocCode').AsInteger:=DataModuleDMK.LocCode;
     ParamByName('@Operator').AsInteger:=DataModuleDMK.Operator;
     ParamByName('@InsurCaseNum').AsInteger:=InsurCaseNum;
     ParamByName('@ClientNum').AsString:=ClientNum;
     ParamByName('@MKBDiagNum').AsString:=MaskEditMKBDiag.Text;
     ParamByName('@DiagNum').AsInteger:=Integer(ComboBoxDiag.Items.Objects[ComboBoxDiag.ItemIndex]);
     ParamByName('@DoctorNum').AsInteger:=Integer(ComboBoxDoctor.Items.Objects[ComboBoxDoctor.ItemIndex]);
     ParamByName('@BranchNum').AsInteger:=Integer(ComboBoxBranch.Items.Objects[ComboBoxBranch.ItemIndex]);
     ParamByName('@HospitalNum').AsInteger:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
     ParamByName('@IllNum').AsInteger:=Integer(ComboBoxIll.Items.Objects[ComboBoxIll.ItemIndex]);
     ParamByName('@TreatNum').AsInteger:=Integer(ComboBoxTreat.Items.Objects[ComboBoxTreat.ItemIndex]);
     ParamByName('@SickList').AsString:=EditSickList.Text;
     ParamByName('@InsurNum').AsInteger:=InsurNum;

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

     if DateEditReestr.Date<>0 then
       ParamByName('@ReestrDate').AsDate:=DateEditReestr.Date
     else
       ParamByName('@ReestrDate').Clear;

     ParamByName('@Akt').AsString:=EditAkt.Text;
     ParamByName('@AktSum').AsFloat:=RxCalcEditAktSum.Value;
     ParamByName('@Comment').AsString:=EditComment.Text;
     ParamByName('@PayPercent').AsFloat:=RxCalcEditPayPercent.Value;

     if ParamByName('@TreatNum').AsString='' then
      raise Exception.Create('Не ввели тип лечения');

     ExecProc;
     InsurCaseNum:=ParamByName('@InsurCaseNum').AsInteger;
     if MainForm.NStart.Enabled then
      DataModuleDMK.AsaSessionDMK.Commit;
     if FirstInsur then
      begin
       if (MessageDlg('Будем выдавать деньги?',mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
         begin
          ButtonNewOrder.Enabled:=True;
          ButtonUnOrder.Enabled:=True;
          ButtonNewOrderClick(Sender);
         end
       else
         InsNewOtherLPUForm.Close;
      end
     else
       InsNewOtherLPUForm.Close;
 end;    // with
 except
   on e: Exception do
    begin
     DataModuleDMK.AsaSessionDMK.Rollback;
     ShowMessage('Ошибка сохранения '+e.Message);
    end;
 end;    // try/except
end;

procedure TInsNewOtherLPUForm.FillComboDiag(MKBDiag:string);
begin
 with DataModuleDMK.AsaStoredProcListDiagnosis do
 begin
   ParamByName('@MKBDiagNum').AsString:=MKBDiag;
   Open;
   ComboBoxDiag.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxDiag.Items.AddObject(DataModuleDMK.AsaStoredProcListDiagnosisDiagName.AsString,TObject(DataModuleDMK.AsaStoredProcListDiagnosisDiagNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;

procedure TInsNewOtherLPUForm.FillComboTreat;
begin
 with DataModuleDMK.AsaStoredProcListTreatment do
 begin
   ParamByName('@StartTreat').Value:=-1;
   ParamByName('@EndTreat').Value:=200;
   Open;
   ComboBoxTreat.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxTreat.Items.AddObject(DataModuleDMK.AsaStoredProcListTreatmentTreatName.AsString,TObject(DataModuleDMK.AsaStoredProcListTreatmentTreatNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;

procedure TInsNewOtherLPUForm.FillComboHospital;
begin
 ComboBoxHospital.Items.Assign(InsNewInsurForm.ComboBoxHospital.Items);
end;

procedure TInsNewOtherLPUForm.FillComboIll;
begin
 ComboBoxIll.Items.Assign(InsNewInsurForm.ComboBoxIll.Items);
end;

procedure TInsNewOtherLPUForm.FormDeactivate(Sender: TObject);
begin
  DataModuleDMK.AsaStoredProcListFinOtherLPU.Close;
end;

procedure TInsNewOtherLPUForm.ButtonNewOrderClick(Sender: TObject);
begin
  InsFinForm.ShowModal;
  DataModuleDMK.AsaStoredProcListFinOtherLPU.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
  RefreshQuery(DataModuleDMK.AsaStoredProcListFinOtherLPU);
end;

procedure TInsNewOtherLPUForm.FormCreate(Sender: TObject);
begin
   FillComboTreat;
   FillComboHospital;
   FillComboDoctor;
   FillComboIll;
   FillComboBranch;
end;

procedure TInsNewOtherLPUForm.ButtonUnOrderClick(Sender: TObject);
begin
  if MessageDlg('Вы уверены, что хотите сделать откат?',
    mtConfirmation, [mbYes,mbNo], 0) = mrNo then Exit;

  with DataModuleDMK.AsaStoredProcUnFin do
  begin
    ParamByName('@LocCode').Value:=DataModuleDMK.LocCode;
    ParamByName('@FinNum').Value:=DataModuleDMK.AsaStoredProcListFinOtherLPUFinNum.Value;
    ParamByName('@Operator').Value:=DataModuleDMK.Operator;
    ExecProc;
  end;    // with
  RefreshQuery(DataModuleDMK.AsaStoredProcListFinOtherLPU);
end;

procedure TInsNewOtherLPUForm.MaskEditMKBDiagChange(Sender: TObject);
begin
   DataModuleDMK.AsaStoredProcShowMKBDiag.Close;
   DataModuleDMK.AsaStoredProcShowMKBDiag.ParamByName('@MKBDiagNum').Value:=MaskEditMKBDiag.Text;
   DataModuleDMK.AsaStoredProcShowMKBDiag.Open;
   MemoMKBDiagName.Text:=DataModuleDMK.AsaStoredProcShowMKBDiagMKBDiagName.Value;
   FillComboDiag(MaskEditMKBDiag.Text);
   ComboBoxDiag.ItemIndex:=0;
   DataModuleDMK.AsaStoredProcShowMKBDiag.Close;
end;

procedure TInsNewOtherLPUForm.MaskEditMKBDiagKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key=VK_F1) then
  begin
   ListMKBDiagForm.ShowModal;
   MaskEditMKBDiag.Text:=DataModuleDMK.AsaStoredProcListMKBDiagMKBDiagNum.Value;
   MaskEditMKBDiagChange(Sender);
   ComboBoxDiag.SetFocus;
  end;
end;

procedure TInsNewOtherLPUForm.ButtonEditDiagClick(Sender: TObject);
begin
 with DiagnosisForm do
 begin
    DiagNum:=Integer(ComboBoxDiag.Items.Objects[ComboBoxDiag.ItemIndex]);
    ShowModal;
 end;    // with
end;

procedure TInsNewOtherLPUForm.ButtonInsDiagClick(Sender: TObject);
begin
 with DiagnosisForm do
 begin
  DiagNum:=-1;
  ShowModal;
 end;
end;

procedure TInsNewOtherLPUForm.ButtonEditHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewOtherLPUForm.ButtonInsHospitalClick(Sender: TObject);
begin
 with HospitalForm do
 begin
  HospitalNum:=-1;
  ShowModal;
 end;    // with
end;

procedure TInsNewOtherLPUForm.ButtonEditDoctorClick(Sender: TObject);
begin
 with DoctorForm do
 begin
  DoctorNum:=Integer(ComboBoxDoctor.Items.Objects[ComboBoxDoctor.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewOtherLPUForm.ButtonInsDoctorClick(Sender: TObject);
begin
 with DoctorForm do
 begin
  DoctorNum:=-1;
  ShowModal;
 end;    // with
end;

procedure TInsNewOtherLPUForm.MaskEditMKBDiagEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000409', KLF_ACTIVATE); // английский
end;

procedure TInsNewOtherLPUForm.EditCommentEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

procedure TInsNewOtherLPUForm.FillComboDoctor;
begin
 with DataModuleDMK.AsaStoredProcListDoctor do
 begin
   Open;
   ComboBoxDoctor.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxDoctor.Items.AddObject(DataModuleDMK.AsaStoredProcListDoctorDoctorName.AsString,TObject(DataModuleDMK.AsaStoredProcListDoctorDoctorNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;

procedure TInsNewOtherLPUForm.FillComboBranch;
begin
 with DataModuleDMK.AsaStoredProcListBranch do
 begin
   Open;
   ComboBoxBranch.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxBranch.Items.AddObject(DataModuleDMK.AsaStoredProcListBranchBranchName.AsString,TObject(DataModuleDMK.AsaStoredProcListBranchBranchNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;


procedure TInsNewOtherLPUForm.ComboBoxHospitalChange(Sender: TObject);
begin
  if Integer(ComboBoxHospital.Items.Objects[ComboBoxHospital.ItemIndex])=517 then
    RxCalcEditPayPercent.Value:=7
  else
    RxCalcEditPayPercent.Value:=15;

end;

procedure TInsNewOtherLPUForm.ButtonEditBranchClick(Sender: TObject);
begin
 with BranchForm do
 begin
  BranchNum:=Integer(ComboBoxBranch.Items.Objects[ComboBoxBranch.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewOtherLPUForm.ButtonInsBranchClick(Sender: TObject);
begin
 with BranchForm do
 begin
  BranchNum:=-1;
  ShowModal;
 end;    // with
end;

end.
