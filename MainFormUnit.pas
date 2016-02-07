unit MainFormUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DataUnit, StdCtrls, Placemnt, SpeedBar, ExtCtrls, ComCtrls, DBUtils;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    N7: TMenuItem;
    NClientManual: TMenuItem;
    N10: TMenuItem;
    NListClient: TMenuItem;
    NExit: TMenuItem;
    N5: TMenuItem;
    NExport: TMenuItem;
    NImport: TMenuItem;
    Jn1: TMenuItem;
    NDesigner: TMenuItem;
    N22: TMenuItem;
    NPrintReport: TMenuItem;
    SpeedBar: TSpeedBar;
    FormStorage: TFormStorage;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    SpeedItemNewClient: TSpeedItem;
    SpeedItemList: TSpeedItem;
    SpeedItemDesigner: TSpeedItem;
    SpeedItemPrint: TSpeedItem;
    SpeedbarSection4: TSpeedbarSection;
    SpeedItemExit: TSpeedItem;
    NPayment: TMenuItem;
    J1: TMenuItem;
    ProgressBar: TProgressBar;
    N6: TMenuItem;
    N8: TMenuItem;
    N3: TMenuItem;
    N11: TMenuItem;
    SpeedbarSection1: TSpeedbarSection;
    SpeedItemAcc: TSpeedItem;
    SpeedItemMaxInsur: TSpeedItem;
    procedure NExitClick(Sender: TObject);
    procedure NListClientClick(Sender: TObject);
    procedure NClientManualClick(Sender: TObject);
    procedure NExportClick(Sender: TObject);
    procedure NImportClick(Sender: TObject);
    procedure NDesignerClick(Sender: TObject);
    procedure NPrintReportClick(Sender: TObject);
    procedure J1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure SpeedItemAccClick(Sender: TObject);
    procedure SpeedItemMaxInsurClick(Sender: TObject);
    procedure NPaymentClick(Sender: TObject);
    procedure N11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses ListClientUnit, ImpExUnit, ReportUnit, AboutUnit, InsNewClientUnit,
  ExpManUnit, LibUnit, ListFinFactUnit, ListMaxInsurUnit, NewAutoPayUnit;

{$R *.DFM}

procedure TMainForm.NExitClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.NListClientClick(Sender: TObject);
begin
  ListClientForm.ShowModal;
end;

procedure TMainForm.NClientManualClick(Sender: TObject);
begin
  InsNewClientForm.ClientID:=-1;
  InsNewClientForm.InsurNum:=-1;
  InsNewClientForm.FactoryNum:=-1;
  InsNewClientForm.ShowModal;
  RefreshQuery(DataModuleHM.AsaStoredProcListClients);
end;

procedure TMainForm.NExportClick(Sender: TObject);
begin
  ImportExportModule.CreateExport;
end;

procedure TMainForm.NImportClick(Sender: TObject);
begin
  ImportExportModule.ExecuteImport;
end;

procedure TMainForm.NDesignerClick(Sender: TObject);
begin
  if Trial then
     Exit;
  ReportModuleHM.frReport.DesignReport;
end;

procedure TMainForm.NPrintReportClick(Sender: TObject);
begin
  if Trial then
     Exit;
  ReportModuleHM.PrintUserReport;
end;

procedure TMainForm.J1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.N8Click(Sender: TObject);
begin
  ExpManForm.ShowModal;
end;

procedure TMainForm.SpeedItemAccClick(Sender: TObject);
begin
  ListFinFactForm.ShowModal;
end;

procedure TMainForm.SpeedItemMaxInsurClick(Sender: TObject);
begin
 ListMaxInsurForm.ShowModal;
end;

procedure TMainForm.NPaymentClick(Sender: TObject);
begin
  NewAutopayForm.ShowModal;
end;

procedure TMainForm.N11Click(Sender: TObject);
begin
  ListFinFactForm.ShowModal;
end;

end.
