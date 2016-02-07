unit ListFinFactUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Grids, DBGridEh, ExtCtrls, DBUtils;

type
  TListFinFactForm = class(TForm)
    PanelTop: TPanel;
    PanelBottom: TPanel;
    ListFinFactDBGridEh: TDBGridEh;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Label1: TLabel;
    ButtonNew: TButton;
    ButtonEdit: TButton;
    ButtonExit: TButton;
    ComboBoxFind: TComboBox;
    EditFind: TEdit;
    ButtonFind: TButton;
    ButtonDel: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure ButtonNewClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonFindClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  ListFinFactForm: TListFinFactForm;

implementation

{$R *.DFM}

uses DataUnit, InsNewFinFactUnit, MainFormUnit;


procedure TListFinFactForm.FormActivate(Sender: TObject);
begin
   DataModuleHM.AsaStoredProcListFinFact.Open;
end;

procedure TListFinFactForm.FormDeactivate(Sender: TObject);
begin
   DataModuleHM.AsaStoredProcListFinFact.Close;
end;

procedure TListFinFactForm.ButtonExitClick(Sender: TObject);
begin
  Close;
end;

procedure TListFinFactForm.ButtonNewClick(Sender: TObject);
begin
  with InsNewFinFactForm do
  begin
    FinFactNum:=-1;
    ShowModal;
  end;
  RefreshQuery(DataModuleHM.AsaStoredProcListFinFact);
end;

procedure TListFinFactForm.ButtonEditClick(Sender: TObject);
begin
  with InsNewFinFactForm do
  begin
    FinFactNum:=DataModuleHM.AsaStoredProcListFinFactFinFactNum.Value;
    ShowModal;
  end;
  RefreshQuery(DataModuleHM.AsaStoredProcListFinFact);
end;

procedure TListFinFactForm.ButtonFindClick(Sender: TObject);
begin
 DataModuleHM.AsaStoredProcListFinFact.Close;
 if EditFind.Text='' then
 begin
    DataModuleHM.AsaStoredProcListFinFact.ParamByName('@Finance').Clear;
    DataModuleHM.AsaStoredProcListFinFact.ParamByName('@Contract').Clear;
 end
 else
  if ComboBoxFind.ItemIndex<=0 then
   begin
     DataModuleHM.AsaStoredProcListFinFact.ParamByName('@Finance').Value:=StrToFloat(EditFind.Text);
     DataModuleHM.AsaStoredProcListFinFact.ParamByName('@Contract').Clear;
   end
  else
   begin
     DataModuleHM.AsaStoredProcListFinFact.ParamByName('@Finance').Clear;
     DataModuleHM.AsaStoredProcListFinFact.ParamByName('@Contract').Value:=EditFind.Text;
   end;
 DataModuleHM.AsaStoredProcListFinFact.Open
end;

procedure TListFinFactForm.ButtonDelClick(Sender: TObject);
begin
 try
   // statements to try
 with DataModuleHM.AsaStoredProcRefrFinFact do
 begin
     ParamByName('@FinFactNum').AsInteger:=DataModuleHM.AsaStoredProcListFinFactFinFactNum.Value;
     ParamByName('@Finance').Clear;
     ParamByName('@Contract').Clear;
     ParamByName('@Comment').Clear;
     ParamByName('@FinFactTypeNum').Clear;
     ParamByName('@RecieverNum').Clear;
     ParamByName('@FinFactDate').Clear;
     ParamByName('@DateDeliver').Clear;
     ExecProc;
 end;    // with
 except
   on e: Exception do
    begin
     DataModuleHM.AsaSessionHM.Rollback;
     ShowMessage('Ошибка сохранения '+e.Message);
    end;
 end;    // try/except
  RefreshQuery(DataModuleHM.AsaStoredProcListFinFact);
end;

end.
