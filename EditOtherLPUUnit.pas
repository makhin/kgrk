unit EditOtherLPUUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, DBGridEh, StdCtrls, DBUtils, DBCtrls;

type
  TEditOtherLPUForm = class(TForm)
    PanelTop: TPanel;
    LabelClientNum: TLabel;
    LabelClientName: TLabel;
    PanelBottom: TPanel;
    DBGridEhListOtherLPUCase: TDBGridEh;
    ButtonEdit: TButton;
    ButtonIns: TButton;
    ButtonExit: TButton;
    DBTextComment: TDBText;
    ButtonDel: TButton;
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
    ClientNum: string;
    InsurNum:Integer;
  end;

var
  EditOtherLPUForm: TEditOtherLPUForm;

implementation

{$R *.DFM}

uses DataUnit, InsNewOtherLPUUnit;

procedure TEditOtherLPUForm.FormActivate(Sender: TObject);
begin
  with DataModuleDMK do
  begin
    AsaStoredProcShowClient.ParamByName('@ClientNum').Value:=ClientNum;
    AsaStoredProcShowClient.ParamByName('@InsurNum').Value:=InsurNum;
    AsaStoredProcShowClient.Open;
    LabelClientNum.Caption:=AsaStoredProcShowClient.FieldByName('ClientNum').AsString;
    LabelClientName.Caption:=AsaStoredProcShowClient.FieldByName('ClientName').AsString;
    AsaStoredProcListInsurCase.ParamByName('@ClientNum').Value:=ClientNum;
    AsaStoredProcListInsurCase.ParamByName('@InsurNum').Value:=InsurNum;
    AsaStoredProcListInsurCase.ParamByName('@HospitalNum').Value:=1;
    AsaStoredProcListInsurCase.Open;
  end;    // with
end;

procedure TEditOtherLPUForm.FormDeactivate(Sender: TObject);
begin
  with DataModuleDMK do
  begin
    AsaStoredProcShowClient.Close;
    AsaStoredProcListInsurCase.Close;
  end;
end;

procedure TEditOtherLPUForm.ButtonEditClick(Sender: TObject);
begin
  if DataModuleDMK.AsaStoredProcListInsurCase.EOF then Exit;
  with InsNewOtherLPUForm do
  begin
    InsurCaseNum:=DataModuleDMK.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    InsurNum:=Self.InsurNum;
    ClientNum:=Self.ClientNum;
    ShowModal;
  end;    // with
  RefreshQuery(DataModuleDMK.AsaStoredProcListInsurCase);
end;

procedure TEditOtherLPUForm.ButtonInsClick(Sender: TObject);
begin
  with InsNewOtherLPUForm do
  begin
    InsNewOtherLPUForm.InsurCaseNum:=-1;
    InsurNum:=Self.InsurNum;
    ClientNum:=Self.ClientNum;
    ShowModal;
  end;
  RefreshQuery(DataModuleDMK.AsaStoredProcListInsurCase);
end;

procedure TEditOtherLPUForm.ButtonExitClick(Sender: TObject);
begin
 Close;
end;

procedure TEditOtherLPUForm.ButtonDelClick(Sender: TObject);
var Fin:Currency;
begin
  with DataModuleDMK do
  begin
    AsaStoredProcShowOtherLPU.ParamByName('@InsurCaseNum').Value:=AsaStoredProcListInsurCaseInsurCaseNum.Value;
    AsaStoredProcShowOtherLPU.Open;
    Fin:=AsaStoredProcShowOtherLPUFin.Value;
    AsaStoredProcShowOtherLPU.Close;
    if Fin<>0 then
     begin
       ShowMessage('Сумма по выдачам не равна нулю,'+#13+'сначала сделайте все откаты');
       Exit;
     end
    else
     begin
       AsaStoredProcUnOtherLPU.ParamByName('@InsurCaseNum').Value:=AsaStoredProcListInsurCaseInsurCaseNum.Value;
       AsaStoredProcUnOtherLPU.ExecProc;
       AsaStoredProcListInsurCase.Close;
       AsaStoredProcListInsurCase.Open;
     end;
  end;    // with}
end;

end.
