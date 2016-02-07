unit ListInOutUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, DBGridEh, DBCtrls, StdCtrls, Buttons, Mask, ToolEdit,
  CurrEdit;

type
  TInOutListForm = class(TForm)
    Panel: TPanel;
    DBNavigatorListInOut_s: TDBNavigator;
    DBGridEhListInOut_s: TDBGridEh;
    BitBtnPrint: TBitBtn;
    BitBtnExit: TBitBtn;
    CurrencyEditFind: TCurrencyEdit;
    BitBtnFind: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
    procedure BitBtnExitClick(Sender: TObject);
    procedure BitBtnFindClick(Sender: TObject);
    procedure CurrencyEditFindKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InOutListForm: TInOutListForm;

implementation

{$R *.DFM}

uses DataUnit, ReportUnit;

procedure TInOutListForm.FormActivate(Sender: TObject);
begin
  DataModuleHM.AsaStoredProcListInOut_s.Open;
end;

procedure TInOutListForm.FormDeactivate(Sender: TObject);
begin
  DataModuleHM.AsaStoredProcListInOut_s.Close;
end;

procedure TInOutListForm.BitBtnPrintClick(Sender: TObject);
begin
  ReportModuleHM.PrintInOut(DataModuleHM.AsaStoredProcListInOut_sInOutNum.Value);
end;

procedure TInOutListForm.BitBtnExitClick(Sender: TObject);
begin
 Close;
end;

procedure TInOutListForm.BitBtnFindClick(Sender: TObject);
begin
  DataModuleHM.AsaStoredProcListInOut_s.Locate('TotalSale',CurrencyEditFind.Value,[]);
end;

procedure TInOutListForm.CurrencyEditFindKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key=#13 then
    BitBtnFindClick(Sender);
end;

end.
