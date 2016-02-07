unit LimitUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TLimitForm = class(TForm)
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    Label2: TLabel;
    CurrencyEditInsurLimit: TCurrencyEdit;
    MemoInsurLimitName: TEdit;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure MemoInsurLimitNameEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InsurLimitNum:Integer;
  end;

var
  LimitForm: TLimitForm;

implementation

uses DataUnit, InsNewMedUnit;

{$R *.DFM}

procedure TLimitForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TLimitForm.FormActivate(Sender: TObject);
begin
  with DataModuleHM.AsaStoredProcShowInsurLimit do
 begin
   ParamByName('@InsurLimitNum').Value:=InsurLimitNum;
   Open;
   MemoInsurLimitName.Text:=DataModuleHM.AsaStoredProcShowInsurLimitInsurLimitName.Value;
   CurrencyEditInsurLimit.Value:=DataModuleHM.AsaStoredProcShowInsurLimitInsurLimitMoney.Value;
   Close;
 end;    // with
 MemoInsurLimitName.SetFocus;
end;

procedure TLimitForm.BitBtnSaveClick(Sender: TObject);
var new:Boolean;
begin
 new:=InsurLimitNum=-1;
 if MemoInsurLimitName.Text='' then
 begin
  ShowMessage('Введи Название');
  MemoInsurLimitName.SetFocus;
  Exit;
 end;
 try
   // statements to try
 begin
  with DataModuleHM do
  begin
   AsaSessionHM.StartTransaction;
   AsaStoredProcRefrInsurLimit.ParamByName('@InsurLimitNum').Value:=InsurLimitNum;
   AsaStoredProcRefrInsurLimit.ParamByName('@InsurLimitName').Value:=MemoInsurLimitName.Text;
   AsaStoredProcRefrInsurLimit.ParamByName('@InsurLimitMoney').Value:=CurrencyEditInsurLimit.Value;
   AsaStoredProcRefrInsurLimit.ExecProc;
   InsurLimitNum:=AsaStoredProcRefrInsurLimit.ParamByName('@InsurLimitNum').Value;
   AsaSessionHM.Commit;
  end;
  if new then
    with InsNewMedForm.ComboBoxLimit do
    begin
      Items.AddObject(MemoInsurLimitName.Text, TObject(InsurLimitNum));
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

procedure TLimitForm.MemoInsurLimitNameEnter(Sender: TObject);
begin
 LoadKeyboardLayout('00000419', KLF_ACTIVATE); // русский
end;

end.
