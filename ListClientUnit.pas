unit ListClientUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBIndex, Grids, DBGridEh, DBUtils, DBCtrls, Mask,
  dxDBTLCl, dxGrClms, dxTL, dxDBCtrl, dxDBGrid, dxCntner;

type
  TListClientForm = class(TForm)
    Panel: TPanel;
    EditFindClient: TEdit;
    ButtonFind: TButton;
    ButtonMedic: TButton;
    ButtonEdit: TButton;
    ButtonIns: TButton;
    ButtonHealth: TButton;
    ButtonFin: TButton;
    PanelBottom: TPanel;
    DBText3: TDBText;
    DBText4: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    ComboBoxFind: TComboBox;
    DBGridEhClient: TdxDBGrid;
    DBGridEhClientClientNum: TdxDBGridMaskColumn;
    DBGridEhClientClientName: TdxDBGridMaskColumn;
    DBGridEhClientFactoryName: TdxDBGridMaskColumn;
    DBGridEhClientMaxInsurName: TdxDBGridMaskColumn;
    DBGridEhClientBeginDate: TdxDBGridDateColumn;
    DBGridEhClientTermDate: TdxDBGridDateColumn;
    ButtonHealthM: TButton;
    DBGridEhClientPayMedStac: TdxDBGridCurrencyColumn;
    DBGridEhClientPayMedAmb: TdxDBGridCurrencyColumn;
    DBGridEhClientMedCountAmb: TdxDBGridMaskColumn;
    DBGridEhClientMedCountStac: TdxDBGridMaskColumn;
    DBGridEhClientMedMedAmb: TdxDBGridCurrencyColumn;
    DBGridEhClientMedMedStac: TdxDBGridCurrencyColumn;
    dxDBGriRemainders: TdxDBGrid;
    dxDBGriRemaindersTreatName: TdxDBGridMaskColumn;
    dxDBGriRemaindersLimit: TdxDBGridCurrencyColumn;
    dxDBGriRemainderstotal: TdxDBGridCurrencyColumn;
    dxDBGriRemaindersMedLimit: TdxDBGridCurrencyColumn;
    dxDBGriRemaindersmed: TdxDBGridCurrencyColumn;
    dxDBGriRemaindersServLimit: TdxDBGridCurrencyColumn;
    dxDBGriRemaindersserv: TdxDBGridCurrencyColumn;
    DBGridEhClientMedStacDS0: TdxDBGridCurrencyColumn;
    DBGridEhClientMedStacDS1: TdxDBGridCurrencyColumn;
    DBGridEhClientMedMedEmerg: TdxDBGridCurrencyColumn;
    DBGridEhClientMedCountEmerg: TdxDBGridMaskColumn;
    DBGridEhClientPayMedEmerg: TdxDBGridCurrencyColumn;
    DBGridEhClientHealthCount: TdxDBGridMaskColumn;
    DBGridEhClientPayHealth: TdxDBGridCurrencyColumn;
    DBGridEhClientColumnComment: TdxDBGridColumn;
    Label3: TLabel;
    Label4: TLabel;
    DBText5: TDBText;
    DBText6: TDBText;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ButtonFindClick(Sender: TObject);
    procedure EditFindClientKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonInsClick(Sender: TObject);
    procedure ButtonMedicClick(Sender: TObject);
    procedure ButtonHealthClick(Sender: TObject);
    procedure ButtonFinClick(Sender: TObject);
    procedure EditFindClientEnter(Sender: TObject);
    procedure ButtonHealthMClick(Sender: TObject);
    procedure DBGridEhClientCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
      const AText: String; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListClientForm: TListClientForm;

implementation

uses DataUnit, InsNewClientUnit, ListFinUnit, ListInsurUnit;

{$R *.DFM}
procedure TListClientForm.FormActivate(Sender: TObject);
begin
  ComboBoxFind.ItemIndex:=0;
  DataModuleHM.AsaStoredProcListClients.Open;
end;

procedure TListClientForm.FormDeactivate(Sender: TObject);
begin
  DataModuleHM.AsaStoredProcListClients.Close;
end;

procedure TListClientForm.ButtonFindClick(Sender: TObject);
begin
  with DataModuleHM.AsaStoredProcListClients do
  begin
    Close;
    if ComboBoxFind.ItemIndex=0 then
     begin
      ParamByName('@ClientName').Value:=EditFindClient.Text;
      ParamByName('@ClientNum').Value:='';
     end
    else
     begin
      ParamByName('@ClientNum').Value:=EditFindClient.Text;
      ParamByName('@ClientName').Value:='';
     end;
    Open;
  end;    // with
end;

procedure TListClientForm.EditFindClientKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key=#13 then
   ButtonFindClick(Sender);
end;

procedure TListClientForm.ButtonEditClick(Sender: TObject);
begin
  InsNewClientForm.ClientID:=DataModuleHM.AsaStoredProcListClientsClientID.Value;
  InsNewClientForm.ShowModal;
  RefreshQuery(DataModuleHM.AsaStoredProcListClients);
end;

procedure TListClientForm.ButtonInsClick(Sender: TObject);
begin
  InsNewClientForm.ClientID:=-1;
  InsNewClientForm.InsurNum:=DataModuleHM.AsaStoredProcListClientsInsurNum.Value;
  InsNewClientForm.FactoryNum:=DataModuleHM.AsaStoredProcListClientsFactoryNum.Value;
  InsNewClientForm.ShowModal;
  RefreshQuery(DataModuleHM.AsaStoredProcListClients);
end;

procedure TListClientForm.ButtonMedicClick(Sender: TObject);
begin
  ListInsurForm.ClientID:=DataModuleHM.AsaStoredProcListClientsClientID.Value;
  ListInsurForm.InsurNum:=DataModuleHM.AsaStoredProcListClientsInsurNum.Value;
  ListInsurForm.FactoryNum:=DataModuleHM.AsaStoredProcListClientsFactoryNum.Value;
  ListInsurForm.TypeInsurCase:=0;
  ListInsurForm.ShowModal;
  RefreshQuery(DataModuleHM.AsaStoredProcListClients);
end;

procedure TListClientForm.ButtonHealthClick(Sender: TObject);
begin
  ListInsurForm.ClientID:=DataModuleHM.AsaStoredProcListClientsClientID.Value;
  ListInsurForm.InsurNum:=DataModuleHM.AsaStoredProcListClientsInsurNum.Value;
  ListInsurForm.FactoryNum:=DataModuleHM.AsaStoredProcListClientsFactoryNum.Value;
  ListInsurForm.TypeInsurCase:=1;
  ListInsurForm.ShowModal;
  RefreshQuery(DataModuleHM.AsaStoredProcListClients);
end;

procedure TListClientForm.ButtonFinClick(Sender: TObject);
begin
  ListFinForm.ClientID:=DataModuleHM.AsaStoredProcListClientsClientID.Value;
  ListFinForm.ShowModal;
end;

procedure TListClientForm.EditFindClientEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

procedure TListClientForm.ButtonHealthMClick(Sender: TObject);
begin
  ListInsurForm.ClientID:=DataModuleHM.AsaStoredProcListClientsClientID.Value;
  ListInsurForm.InsurNum:=DataModuleHM.AsaStoredProcListClientsInsurNum.Value;
  ListInsurForm.FactoryNum:=DataModuleHM.AsaStoredProcListClientsFactoryNum.Value;
  ListInsurForm.TypeInsurCase:=2;
  ListInsurForm.ShowModal;
  RefreshQuery(DataModuleHM.AsaStoredProcListClients);
end;

procedure TListClientForm.DBGridEhClientCustomDraw(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxDBTreeListColumn; const AText: String; AFont: TFont;
  var AColor: TColor; ASelected, AFocused: Boolean; var ADone: Boolean);
begin
//if AColumn.Index > 3 then
//        If (Trim(ANode.Values[DBGridEhClientColumnComment.Index]) <> '') and (ANode.Values[2] <> ANode.Values[1]) then
//                AFont.Color := clRed;
end;

end.
