unit ListHealthUnit;

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
    FactoryNum:Integer;
  end;

var
  ListMedForm: TListMedForm;

implementation

{$R *.DFM}

uses DataUnit, InsNewMedUnit;

procedure TListMedForm.FormActivate(Sender: TObject);
begin
  with DataModuleHM do
  begin
    AsaStoredProcShowClient.ParamByName('@ClientNum').Value:=ClientNum;
    AsaStoredProcShowClient.ParamByName('@InsurNum').Value:=InsurNum;
    AsaStoredProcShowClient.ParamByName('@FactoryNum').Value:=FactoryNum;
    AsaStoredProcShowClient.Open;
    LabelClientNum.Caption:=AsaStoredProcShowClient.FieldByName('ClientNum').Value;
    LabelClientName.Caption:=AsaStoredProcShowClient.FieldByName('ClientName').Value;
    AsaStoredProcListInsurCase.ParamByName('@ClientNum').Value:=ClientNum;
    AsaStoredProcListInsurCase.ParamByName('@InsurNum').Value:=InsurNum;
    AsaStoredProcListInsurCase.ParamByName('@FactoryNum').Value:=FactoryNum;
    AsaStoredProcListInsurCase.ParamByName('@IsHealth').Value:=False;
    AsaStoredProcListInsurCase.Open;
  end;    // with
end;

procedure TListMedForm.FormDeactivate(Sender: TObject);
begin
  with DataModuleHM do
  begin
    AsaStoredProcShowClient.Close;
    AsaStoredProcListInsurCase.Close;
  end;
end;

procedure TListMedForm.ButtonEditClick(Sender: TObject);
begin
  if DataModuleHM.AsaStoredProcListInsurCase.EOF then Exit;
  with InsNewMedForm do
  begin
    InsurCaseNum:=DataModuleHM.AsaStoredProcListInsurCaseInsurCaseNum.Value;
    ClientNum:=Self.ClientNum;
    InsurNum:=Self.InsurNum;
    FactoryNum:=Self.FactoryNum;
    ShowModal;
  end;    // with}
  RefreshQuery(DataModuleHM.AsaStoredProcListInsurCase);
end;

procedure TListMedForm.ButtonInsClick(Sender: TObject);
begin
  with InsNewMedForm do
  begin
    InsurCaseNum:=-1;
    ClientNum:=Self.ClientNum;
    InsurNum:=Self.InsurNum;
    FactoryNum:=Self.FactoryNum;
    ShowModal;
  end;
  RefreshQuery(DataModuleHM.AsaStoredProcListInsurCase);
end;

procedure TListMedForm.ButtonExitClick(Sender: TObject);
begin
 Close;
end;

procedure TListMedForm.ButtonDelClick(Sender: TObject);
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
