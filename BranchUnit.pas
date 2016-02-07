unit BranchUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TBranchForm = class(TForm)
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    Label2: TLabel;
    CurrencyEditBedDay2: TCurrencyEdit;
    MemoBranchName: TEdit;
    Label1: TLabel;
    CurrencyEditBedDay1: TCurrencyEdit;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure MemoBranchNameEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    HospitalNum:Integer;
    BranchNum:Integer;
  end;

var
  BranchForm: TBranchForm;

implementation

uses DataUnit, InsNewMedUnit, InsNewHealthUnit;

{$R *.DFM}

procedure TBranchForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TBranchForm.FormActivate(Sender: TObject);
begin
  with DataModuleHM.AsaStoredProcShowBranch do
 begin
   ParamByName('@BranchNum').Value:=BranchNum;
   Open;
   MemoBranchName.Text:=DataModuleHM.AsaStoredProcShowBranchBranchName.Value;
   CurrencyEditBedDay1.Value:=DataModuleHM.AsaStoredProcShowBranchBedDay1.Value;
   CurrencyEditBedDay2.Value:=DataModuleHM.AsaStoredProcShowBranchBedDay2.Value;
   Close;
 end;    // with
 MemoBranchName.SetFocus;
end;

procedure TBranchForm.BitBtnSaveClick(Sender: TObject);
var new:Boolean;
begin
 new:=BranchNum=-1;
 if MemoBranchName.Text='' then
 begin
  ShowMessage('Введи Название');
  MemoBranchName.SetFocus;
  Exit;
 end;
 try
   // statements to try
 begin
  with DataModuleHM do
  begin
   AsaSessionHM.StartTransaction;
   AsaStoredProcRefrBranch.ParamByName('@BranchNum').Value:=BranchNum;
   AsaStoredProcRefrBranch.ParamByName('@BranchName').Value:=MemoBranchName.Text;
   AsaStoredProcRefrBranch.ParamByName('@HospitalNum').Value:=HospitalNum;
   AsaStoredProcRefrBranch.ParamByName('@BedDay1').Value:=CurrencyEditBedDay1.Value;
   AsaStoredProcRefrBranch.ParamByName('@BedDay2').Value:=CurrencyEditBedDay2.Value;
   AsaStoredProcRefrBranch.ExecProc;
   BranchNum:=AsaStoredProcRefrBranch.ParamByName('@BranchNum').Value;
   AsaSessionHM.Commit;
  end;
  if new then
    with InsNewMedForm.ComboBoxBranch do
    begin
      Items.AddObject(MemoBranchName.Text, TObject(BranchNum));
      ItemIndex:=Items.Count-1;
    end;    // with
  end;
 except
   on e: Exception do
    begin
      ShowMessage('Ошибка '+ e.Message);
      DataModuleHM.AsaSessionHM.RollBack;
    end;
 end;    // try/except
  Close;

end;

procedure TBranchForm.MemoBranchNameEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

end.
