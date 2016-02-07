unit ListFinUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGridEh, StdCtrls, DBCtrls, ExtCtrls;

type
  TListFinForm = class(TForm)
    DBGridEhFin: TDBGridEh;
    PanelBottom: TPanel;
    DBTextComment: TDBText;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ClientID:integer;
  end;

var
  ListFinForm: TListFinForm;

implementation


uses DataUnit;
{$R *.DFM}

procedure TListFinForm.FormActivate(Sender: TObject);
begin
  with DataModuleHM.AsaStoredProcListFin do
  begin
    ParamByName('@ClientID').Value:=ClientID;
    Open;
  end;    // with
end;

procedure TListFinForm.FormDeactivate(Sender: TObject);
begin
   DataModuleHM.AsaStoredProcListFin.Close;
end;

end.
