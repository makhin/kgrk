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

uses DataUnit, InsNewMedUnit, InsNewHealthUnit, InsNewHealthMedicUnit;

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
    InsurCaseNum:=DataModuleHM.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    ClientID:=Self.ClientID;
    InsurNum:=Self.InsurNum;
    FactoryNum:=Self.FactoryNum;
    ShowModal;
  end;    // with}
  if TypeInsurCase=0 then
  with InsNewMedForm do
  begin
    InsurCaseNum:=DataModuleHM.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    ClientID:=Self.ClientID;
    InsurNum:=Self.InsurNum;
    FactoryNum:=Self.FactoryNum;
    ShowModal;
  end;    // with}
  if TypeInsurCase=2 then
  with InsNewHealthMedicForm do
  begin
    InsurCaseNum:=DataModuleHM.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    ClientID:=Self.ClientID;
    InsurNum:=Self.InsurNum;
    FactoryNum:=Self.FactoryNum;
    ShowModal;
  end;    // with}
  RefreshQuery(DataModuleHM.AsaStoredProcListInsurCase);
end;

procedure TListInsurForm.ButtonInsClick(Sender: TObject);
begin
  if TypeInsurCase=1 then
  with InsNewHealthForm do
  begin
    InsurCaseNum:=-1;
    ClientID:=Self.ClientID;
    InsurNum:=Self.InsurNum;
    FactoryNum:=Self.FactoryNum;
    ShowModal;
  end;
  if TypeInsurCase=0 then
  with InsNewMedForm do
  begin
    InsurCaseNum:=-1;
    ClientID:=Self.ClientID;
    InsurNum:=Self.InsurNum;
    FactoryNum:=Self.FactoryNum;
    ShowModal;
  end;
  if TypeInsurCase=2 then
  with InsNewHealthMedicForm do
  begin
    InsurCaseNum:=-1;
    ClientID:=Self.ClientID;
    InsurNum:=Self.InsurNum;
    FactoryNum:=Self.FactoryNum;
    ShowModal;
  end;
  RefreshQuery(DataModuleHM.AsaStoredProcListInsurCase);
end;

procedure TListInsurForm.ButtonExitClick(Sender: TObject);
begin
 Close;
end;

procedure TListInsurForm.ButtonDelClick(Sender: TObject);
begin
  with DataModuleHM do
  begin
    AsaStoredProcUnInsurCase.ParamByName('@LocCode').Value:=LocCode;
    AsaStoredProcUnInsurCase.ParamByName('@Operator').Value:=Operator;
    AsaStoredProcUnInsurCase.ParamByName('@InsurCaseNum').Value:=AsaStoredProcListInsurCaseInsurCaseNum.Value;
    AsaStoredProcUnInsurCase.ExecProc;
    RefreshQuery(DataModuleHM.AsaStoredProcListInsurCase);
  end;    // with
end;

end.
