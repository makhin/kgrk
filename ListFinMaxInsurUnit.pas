unit ListFinMaxInsurUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGridEh;

type
  TListFinMaxInsurForm = class(TForm)
    DBGridEhListFinTreat: TDBGridEh;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure DBGridEhListFinTreatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    MaxInsurNum:Integer;
  end;

var
  ListFinMaxInsurForm: TListFinMaxInsurForm;

implementation

{$R *.DFM}

uses DataUnit;

procedure TListFinMaxInsurForm.FormActivate(Sender: TObject);
begin
 with DataModuleHM.AsaStoredProcListFinMaxInsur do
 begin
  ParamByName('@MaxInsurNum').Value:=MaxInsurNum;
  Open;
 end;    // with
end;

procedure TListFinMaxInsurForm.FormDeactivate(Sender: TObject);
begin
  DataModuleHM.AsaStoredProcListFinMaxInsur.Close;
end;

procedure TListFinMaxInsurForm.DBGridEhListFinTreatKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_DELETE then
  if MessageDlg('Удаляем эту проводку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   with DataModuleHM.AsaStoredProcUnFinTreat do
   begin
     ParamByName('@FinTreatNum').Value:=DataModuleHM.AsaStoredProcListFinMaxInsurFinTreatNum.Value;
     ExecProc;
     DataModuleHM.AsaStoredProcListFinMaxInsur.Close;
     DataModuleHM.AsaStoredProcListMaxInsur.Close;
     DataModuleHM.AsaStoredProcListFinMaxInsur.Open;
     DataModuleHM.AsaStoredProcListMaxInsur.Open;
   end;    // with
end;

end.
