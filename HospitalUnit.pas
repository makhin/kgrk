unit HospitalUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  THospitalForm = class(TForm)
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    MemoHospitalName: TEdit;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MemoHospitalNameEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    HospitalNum:Integer;
  end;

var
  HospitalForm: THospitalForm;

implementation

{$R *.DFM}

uses DataUnit, InsNewMedUnit, InsNewHealthUnit, InsNewFinFactUnit;

procedure THospitalForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure THospitalForm.BitBtnSaveClick(Sender: TObject);
var new:Boolean;
begin
 new:=HospitalNum=-1;
 if MemoHospitalName.Text='' then
 begin
  ShowMessage('Введи Название');
  MemoHospitalName.SetFocus;
  Exit;
 end;
 try
   // statements to try
 begin
  with DataModuleHM do
  begin
   AsaSessionHM.StartTransaction;
   AsaStoredProcRefrHospital.ParamByName('@HospitalNum').Value:=HospitalNum;
   AsaStoredProcRefrHospital.ParamByName('@HospitalName').Value:=MemoHospitalName.Text;
   AsaStoredProcRefrHospital.ExecProc;
   HospitalNum:=AsaStoredProcRefrHospital.ParamByName('@HospitalNum').Value;
   AsaSessionHM.Commit;
  end;
  if new then
  begin
    with InsNewMedForm.ComboBoxHospital do
    begin
      Items.AddObject(MemoHospitalName.Text, TObject(HospitalNum));
      ItemIndex:=Items.Count-1;
    end;    // with
    with InsNewHealthForm.ComboBoxHospital do
    begin
      Items.Assign(InsNewMedForm.ComboBoxHospital.Items);
      ItemIndex:=Items.Count-1;
    end;    // with
    with InsNewFinFactForm.ComboBoxHospital do
    begin
      Items.Assign(InsNewMedForm.ComboBoxHospital.Items);
      ItemIndex:=Items.Count-1;
    end;    // with
  end;  //if
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

procedure THospitalForm.FormActivate(Sender: TObject);
begin
  with DataModuleHM.AsaStoredProcShowHospital do
 begin
   ParamByName('@HospitalNum').Value:=HospitalNum;
   Open;
   MemoHospitalName.Text:=DataModuleHM.AsaStoredProcShowHospitalHospitalName.Value;
   Close;
 end;    // with
 MemoHospitalName.SetFocus;
end;

procedure THospitalForm.MemoHospitalNameEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

end.
