unit ListInsurUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, DBGridEh, StdCtrls, DBUtils, DBCtrls, ComCtrls;

type
  TListInsurForm = class(TForm)
    PanelTop: TPanel;
    LabelClientNum: TLabel;
    LabelClientName: TLabel;
    PanelBottom: TPanel;
    DBGridEhListInsurCase: TDBGridEh;
    ButtonEdit: TButton;
    ButtonIns: TButton;
    ButtonExit: TButton;
    DBTextComment: TDBText;
    ButtonDel: TButton;
    DBTextDiag: TDBText;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonInsClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ClientID: Integer;
    InsurNum:Integer;
    FactoryNum:Integer;
    TypeInsurCase:byte;
  end;

var
  ListInsurForm: TListInsurForm;

implementation

{$R *.DFM}

uses DataUnit, InsNewMedUnit, InsNewHealthUnit, InsNewHealthMedicUnit,
  InsNewInsurUnit;

procedure TListInsurForm.FormActivate(Sender: TObject);
begin
  with DataModuleHM do
  begin
    AsaStoredProcShowClient.ParamByName('@ClientID').Value:=ClientID;
    AsaStoredProcShowClient.Open;
    LabelClientNum.Caption:=AsaStoredProcShowClient.FieldByName('ClientNum').Value;
    LabelClientName.Caption:=AsaStoredProcShowClient.FieldByName('ClientName').Value;
    AsaStoredProcListInsurCase.ParamByName('@ClientID').Value:=ClientID;
    AsaStoredProcListInsurCase.ParamByName('@TypeInsurCase').Value:=TypeInsurCase;
    AsaStoredProcListInsurCase.Open;
  end;    // with
end;

procedure TListInsurForm.FormDeactivate(Sender: TObject);
begin
  with DataModuleHM do
  begin
    AsaStoredProcShowClient.Close;
    AsaStoredProcListInsurCase.Close;
  end;
end;

procedure TListInsurForm.ButtonEditClick(Sender: TObject);
begin
  if DataModuleHM.AsaStoredProcListInsurCase.EOF then Exit;
  if TypeInsurCase=1 then
  with InsNewHealthForm do
  begin
    InsNewHealthForm.InsurCaseNum:=DataModuleHM.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    InsNewHealthForm.ClientID:=Self.ClientID;
    InsNewHealthForm.InsurNum:=Self.InsurNum;
    InsNewHealthForm.FactoryNum:=Self.FactoryNum;
    InsNewHealthForm.TypeInsurCase:=Self.TypeInsurCase;
    ShowModal;
  end;    // with}
  if TypeInsurCase=0 then
  with InsNewMedForm do
  begin
    InsNewMedForm.InsurCaseNum:=DataModuleHM.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    InsNewMedForm.ClientID:=Self.ClientID;
    InsNewMedForm.InsurNum:=Self.InsurNum;
    InsNewMedForm.FactoryNum:=Self.FactoryNum;
    InsNewMedForm.TypeInsurCase:=Self.TypeInsurCase;
    ShowModal;
  end;    // with}
  if TypeInsurCase=2 then
  with InsNewHealthMedicForm do
  begin
    InsNewHealthMedicForm.InsurCaseNum:=DataModuleHM.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    InsNewHealthMedicForm.ClientID:=Self.ClientID;
    InsNewHealthMedicForm.InsurNum:=Self.InsurNum;
    InsNewHealthMedicForm.FactoryNum:=Self.FactoryNum;
    InsNewHealthMedicForm.TypeInsurCase:=Self.TypeInsurCase;
    ShowModal;
  end;    // with}
  if TypeInsurCase=3 then
  with InsNewInsurForm do
  begin
    InsNewInsurForm.InsurCaseNum:=DataModuleHM.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    InsNewInsurForm.ClientID:=Self.ClientID;
    InsNewInsurForm.InsurNum:=Self.InsurNum;
    InsNewInsurForm.FactoryNum:=Self.FactoryNum;
    InsNewInsurForm.TypeInsurCase:=Self.TypeInsurCase;
    ShowModal;
  end;    // with}
  RefreshQuery(DataModuleHM.AsaStoredProcListInsurCase);
end;

procedure TListInsurForm.ButtonInsClick(Sender: TObject);
begin
  if TypeInsurCase=1 then
  with InsNewHealthForm do
  begin
    InsNewHealthForm.InsurCaseNum:=-1;
    InsNewHealthForm.ClientID:=Self.ClientID;
    InsNewHealthForm.InsurNum:=Self.InsurNum;
    InsNewHealthForm.FactoryNum:=Self.FactoryNum;
    InsNewHealthForm.TypeInsurCase:=Self.TypeInsurCase;
    ShowModal;
  end;
  if TypeInsurCase=0 then
  with InsNewMedForm do
  begin
    InsNewMedForm.InsurCaseNum:=-1;
    InsNewMedForm.ClientID:=Self.ClientID;
    InsNewMedForm.InsurNum:=Self.InsurNum;
    InsNewMedForm.FactoryNum:=Self.FactoryNum;
    InsNewMedForm.TypeInsurCase:=Self.TypeInsurCase;
    ShowModal;
  end;
  if TypeInsurCase=2 then
  with InsNewHealthMedicForm do
  begin
    InsNewHealthMedicForm.InsurCaseNum:=-1;
    InsNewHealthMedicForm.ClientID:=Self.ClientID;
    InsNewHealthMedicForm.InsurNum:=Self.InsurNum;
    InsNewHealthMedicForm.FactoryNum:=Self.FactoryNum;
    InsNewHealthMedicForm.TypeInsurCase:=Self.TypeInsurCase;
    ShowModal;
  end;
  if TypeInsurCase=3 then
  with InsNewInsurForm do
  begin
    InsNewInsurForm.InsurCaseNum:=-1;
    InsNewInsurForm.ClientID:=Self.ClientID;
    InsNewInsurForm.InsurNum:=Self.InsurNum;
    InsNewInsurForm.FactoryNum:=Self.FactoryNum;
    InsNewInsurForm.TypeInsurCase:=Self.TypeInsurCase;
    ShowModal;
  end;
  RefreshQuery(DataModuleHM.AsaStoredProcListInsurCase);
end;

procedure TListInsurForm.ButtonExitClick(Sender: TObject);
begin
 Close;
end;

procedure TListInsurForm.ButtonDelClick(Sender: TObject);
var TotalSale:Currency;
begin
  with DataModuleHM do
  begin
    TotalSale := 0;
    If (TypeInsurCase=3) then
     begin
      AsaStoredProcShowInsurCase.ParamByName('@InsurCaseNum').Value:=AsaStoredProcListInsurCaseInsurCaseNum.Value;
      AsaStoredProcShowInsurCase.Open;
      TotalSale:=AsaStoredProcShowInsurCaseTotalSale.Value;
      AsaStoredProcShowInsurCase.Close;
     end;
    if TotalSale<>0 then
     begin
       ShowMessage('Сумма выданных медикаментов не равна нулю,'+#13+'сначала сделайте все откаты');
       Exit;
     end
    else
     begin
      AsaStoredProcUnInsurCase.ParamByName('@LocCode').Value:=LocCode;
      AsaStoredProcUnInsurCase.ParamByName('@Operator').Value:=Operator;
      AsaStoredProcUnInsurCase.ParamByName('@InsurCaseNum').Value:=AsaStoredProcListInsurCaseInsurCaseNum.Value;
      AsaStoredProcUnInsurCase.ExecProc;
      RefreshQuery(DataModuleHM.AsaStoredProcListInsurCase);
     end;
  end;    // with
end;

end.
