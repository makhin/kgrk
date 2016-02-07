unit MedicalUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Grids, DBGridEh, ExtCtrls, DBCtrls, StdCtrls, DBUtils;

type
  TMedicalForm = class(TForm)
    PageControl: TPageControl;
    TabSheetStock: TTabSheet;
    TabSheetMedic: TTabSheet;
    DBGridEhStock: TDBGridEh;
    DBNavigatorMedic: TDBNavigator;
    DBGridEhMedic: TDBGridEh;
    PanelBottom: TPanel;
    EditProdName: TEdit;
    ButtonFind: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ButtonFindClick(Sender: TObject);
    procedure EditProdNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TabSheetStockEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MedicalForm: TMedicalForm;

implementation

Uses DataUnit;

{$R *.DFM}

procedure TMedicalForm.FormActivate(Sender: TObject);
begin
  with DataModuleHM do
  begin
    AsaStoredProcListStockFromName.Open;
    AsaDatasetMedic.Open;
  end;    // with
end;

procedure TMedicalForm.FormDeactivate(Sender: TObject);
begin
  with DataModuleHM do
  begin
    AsaStoredProcListStockFromName.Close;
    AsaDatasetMedic.Close;
  end;    // with
end;

procedure TMedicalForm.ButtonFindClick(Sender: TObject);
begin
 with DataModuleHM.AsaStoredProcListStockFromName do
 begin
   Close;
   ParamByName('@ProdName').Value:=EditProdName.Text;
   Open;
 end;    // with
end;

procedure TMedicalForm.EditProdNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=VK_RETURN then
   ButtonFindClick(Sender);
end;

procedure TMedicalForm.TabSheetStockEnter(Sender: TObject);
begin
  EditProdName.SetFocus;
end;

end.
