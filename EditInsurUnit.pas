unit EditInsurUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, DBGridEh, StdCtrls, DBUtils, DBCtrls;

type
  TListMedForm = class(TForm)
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
  ListMedForm: TListMedForm;

implementation

{$R *.DFM}

uses DataUnit, InsNewInsurUnit;

procedure TListMedForm.FormActivate(Sender: TObject);
begin
  with DataModuleDMK do
  begin
    AsaStoredProcShowClient.ParamByName('@ClientNum').Value:=ClientNum;
    AsaStoredProcShowClient.ParamByName('@InsurNum').Value:=InsurNum;
    AsaStoredProcShowClient.Open;
    LabelClientNum.Caption:=AsaStoredProcShowClient.FieldByName('ClientNum').Value;
    LabelClientName.Caption:=AsaStoredProcShowClient.FieldByName('ClientName').Value;
    AsaStoredProcListInsurCase.ParamByName('@ClientNum').Value:=ClientNum;
    AsaStoredProcListInsurCase.ParamByName('@InsurNum').Value:=InsurNum;
    AsaStoredProcListInsurCase.ParamByName('@HospitalNum').Value:=0;
    AsaStoredProcListInsurCase.Open;
  end;    // with
end;

procedure TListMedForm.FormDeactivate(Sender: TObject);
begin
  with DataModuleDMK do
  begin
    AsaStoredProcShowClient.Close;
    AsaStoredProcListInsurCase.Close;
  end;
end;

procedure TListMedForm.ButtonEditClick(Sender: TObject);
begin
  if DataModuleDMK.AsaStoredProcListInsurCase.EOF then Exit;
  with InsNewInsurForm do
  begin
    InsurCaseNum:=DataModuleDMK.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    ClientNum:=Self.ClientNum;
    InsurNum:=Self.InsurNum;
    ShowModal;
  end;    // with
  RefreshQuery(DataModuleDMK.AsaStoredProcListInsurCase);
end;

procedure TListMedForm.ButtonInsClick(Sender: TObject);
begin
  with InsNewInsurForm do
  begin
    InsurCaseNum:=-1;
    ClientNum:=Self.ClientNum;
    InsurNum:=Self.InsurNum;
    ShowModal;
  end;
  RefreshQuery(DataModuleDMK.AsaStoredProcListInsurCase);
end;

procedure TListMedForm.ButtonExitClick(Sender: TObject);
begin
 Close;
end;

procedure TListMedForm.ButtonDelClick(Sender: TObject);
var TotalSale:Currency;
begin
  with DataModuleDMK do
  begin
    AsaStoredProcShowInsurCase.ParamByName('@InsurCaseNum').Value:=AsaStoredProcListInsurCaseInsurCaseNum.Value;
    AsaStoredProcShowInsurCase.Open;
    TotalSale:=AsaStoredProcShowInsurCaseTotalSale.Value;
    AsaStoredProcShowInsurCase.Close;
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
       AsaStoredProcListInsurCase.Close;
       AsaStoredProcListInsurCase.Open;
     end;
  end;    // with
end;

end.
