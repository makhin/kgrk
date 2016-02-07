unit ListFinTreatUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGridEh;

type
  TListFinTreatForm = class(TForm)
    DBGridEhListFinTreat: TDBGridEh;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure DBGridEhListFinTreatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    TreatNum:Integer;
  end;

var
  ListFinTreatForm: TListFinTreatForm;

implementation

{$R *.DFM}

uses DataUnit;

procedure TListFinTreatForm.FormActivate(Sender: TObject);
begin
 with DataModuleDIM.AsaStoredProcListFinTreat do
 begin
  ParamByName('@TreatNum').Value:=TreatNum;
  Open;
 end;    // with
end;

procedure TListFinTreatForm.FormDeactivate(Sender: TObject);
begin
  DataModuleDIM.AsaStoredProcListFinTreat.Close;
end;

procedure TListFinTreatForm.DBGridEhListFinTreatKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_DELETE then
  if MessageDlg('Удаляем эту проводку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   with DataModuleDIM.AsaStoredProcDeleteFinTreat do
   begin
     ParamByName('@FinTreatNum').Value:=DataModuleDIM.AsaStoredProcListFinTreatFinTreatNum.Value;
     ExecProc;
     DataModuleDIM.AsaStoredProcListFinTreat.Close;
     DataModuleDIM.AsaStoredProcListTreatment.Close;
     DataModuleDIM.AsaStoredProcListTreatment.Open;
     DataModuleDIM.AsaStoredProcListFinTreat.Open;
   end;    // with
end;

end.
