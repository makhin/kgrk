unit ListMKBUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGridEh, StdCtrls, ExtCtrls;

type
  TListMKBDiagForm = class(TForm)
    PanelTop: TPanel;
    MKBDiagNameEdit: TEdit;
    ButtonFind: TButton;
    ButtonExit: TButton;
    DBGridEhDiag: TDBGridEh;
    procedure FormActivate(Sender: TObject);
    procedure MKBDiagNameEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonFindClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure DBGridEhDiagKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MKBDiagNameEditEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListMKBDiagForm: TListMKBDiagForm;

implementation

Uses DataUnit;

{$R *.DFM}

procedure TListMKBDiagForm.FormActivate(Sender: TObject);
begin
  MKBDiagNameEdit.Text:='';
  MKBDiagNameEdit.SetFocus;
end;

procedure TListMKBDiagForm.MKBDiagNameEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then
   ButtonFindClick(Sender);
end;

procedure TListMKBDiagForm.ButtonFindClick(Sender: TObject);
begin
  with DataModuleHM do
  begin
   AsaStoredProcListMKBDiag.Close;
   AsaStoredProcListMKBDiag.ParamByName('@MKBDiagName').Value:=MKBDiagNameEdit.Text;
   AsaStoredProcListMKBDiag.Open;
  end;    // with
   DBGridEhDiag.SetFocus;
end;

procedure TListMKBDiagForm.ButtonExitClick(Sender: TObject);
begin
  Close;
end;

procedure TListMKBDiagForm.DBGridEhDiagKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then
   Close;
end;

procedure TListMKBDiagForm.MKBDiagNameEditEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

end.
