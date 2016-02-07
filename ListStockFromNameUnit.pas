unit ListStockFromNameUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, DBGridEh, DbUtils;

type
  TListStockFromNameForm = class(TForm)
    DBGridEhListStock: TDBGridEh;
    PanelTop: TPanel;
    EditProdName: TEdit;
    ButtonFind: TButton;
    ButtonAdd: TButton;
    procedure ButtonFindClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure EditProdNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEhListStockKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure EditProdNameEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListStockFromNameForm: TListStockFromNameForm;

implementation

{$R *.DFM}

Uses DataUnit, InsNewOrderUnit;

procedure TListStockFromNameForm.ButtonFindClick(Sender: TObject);
begin
   DataModuleHM.AsaStoredProcListStockFromName.Close;
   DataModuleHM.AsaStoredProcListStockFromName.ParamByName('@ProdName').Value:=EditProdName.Text;
   DataModuleHM.AsaStoredProcListStockFromName.Open;
   DBGridEhListStock.SetFocus;
end;

procedure TListStockFromNameForm.FormDeactivate(Sender: TObject);
begin
   DataModuleHM.AsaStoredProcListStockFromName.Close;
end;

procedure TListStockFromNameForm.ButtonAddClick(Sender: TObject);
begin
 with DataModuleHM do
 begin
   RxMemoryDataOrder_dProdCode.Value:=AsaStoredProcListStockFromNameProdCode.Value;
   RxMemoryDataOrder_dProdName.Value:=AsaStoredProcListStockFromNameProdName.Value;
   RxMemoryDataOrder_dCost.Value:=AsaStoredProcListStockFromNameCost.Value;
   DataModuleHM.AsaStoredProcListCostStock.Close;
   DataModuleHM.AsaStoredProcListCostStock.ParamByName('@ProdCode').Value:=DataModuleHM.RxMemoryDataOrder_dProdCode.Value;
   DataModuleHM.AsaStoredProcListCostStock.Open;
 end;    // with
  InsOrderForm.DBGridEhOrder_d.SelectedIndex:=3;
  Close;
end;

procedure TListStockFromNameForm.EditProdNameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key=VK_RETURN then
   ButtonFindClick(Sender);
end;

procedure TListStockFromNameForm.DBGridEhListStockKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then
   ButtonAddClick(Sender);
end;

procedure TListStockFromNameForm.FormActivate(Sender: TObject);
begin
 EditProdName.Text:='';
 EditProdName.SetFocus;
end;

procedure TListStockFromNameForm.EditProdNameEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

end.
