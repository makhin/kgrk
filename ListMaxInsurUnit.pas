unit ListMaxInsurUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGridEh, ExtCtrls, DbUtils;

type
  TListMaxInsurForm = class(TForm)
    PanelTop: TPanel;
    DBGridEhListTreat: TDBGridEh;
    ButtonAdd: TButton;
    ButtonEdit: TButton;
    ButtonDel: TButton;
    ButtonPay: TButton;
    ButtonFin: TButton;
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ButtonPayClick(Sender: TObject);
    procedure ButtonFinClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListMaxInsurForm: TListMaxInsurForm;

implementation

{$R *.DFM}

uses DataUnit, MainFormUnit, InsNewMaxInsurUnit, InsNewClientUnit,
  ListFinMaxInsurUnit, NewPayFromMaxInsurUnit;

procedure TListMaxInsurForm.ButtonEditClick(Sender: TObject);
begin
 with MaxInsurForm do
 begin
   MaxInsurNum:=DataModuleHM.AsaStoredProcListMaxInsurMaxInsurNum.Value;
   ShowModal;
 end;    // with
end;

procedure TListMaxInsurForm.ButtonDelClick(Sender: TObject);
begin
 if MessageDlg('Вы хотите удалить этот договор?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  with DataModuleHM do
  begin
    with InsNewClientForm.ComboBoxMaxInsur do
      Items.Delete(Items.IndexOfObject(TObject(DataModuleHM.AsaStoredProcListMaxInsurMaxInsurNum.Value)));

    AsaStoredProcUnMaxInsur.ParamByName('@MaxInsurNum').Value:=AsaStoredProcListMaxInsurMaxInsurNum.Value;
    AsaStoredProcUnMaxInsur.ExecProc;
    RefreshQuery(DataModuleHM.AsaStoredProcListMaxInsur);
  end;    // with
end;

procedure TListMaxInsurForm.FormActivate(Sender: TObject);
begin
  DataModuleHM.AsaStoredProcListMaxInsur.Open;
end;

procedure TListMaxInsurForm.FormDeactivate(Sender: TObject);
begin
  DataModuleHM.AsaStoredProcListMaxInsur.Close;
end;

procedure TListMaxInsurForm.ButtonPayClick(Sender: TObject);
begin
  NewPayFromMaxInsurForm.ShowModal;
  RefreshQuery(DataModuleHM.AsaStoredProcListMaxInsur);
end;

procedure TListMaxInsurForm.ButtonFinClick(Sender: TObject);
begin
 with ListFinMaxInsurForm do
 begin
   MaxInsurNum:=DataModuleHM.AsaStoredProcListMaxInsurMaxInsurNum.Value;
   ShowModal;
 end;    // with
end;

procedure TListMaxInsurForm.ButtonAddClick(Sender: TObject);
begin
 with MaxInsurForm do
 begin
  MaxInsurNum:=-1;
  ShowModal;
 end;    // with
end;

end.
