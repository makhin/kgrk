unit NewPayFromMaxInsurUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CurrEdit, StdCtrls, Mask, ToolEdit, Buttons;

type
  TNewPayFromMaxInsurForm = class(TForm)
    DateEditFinDate: TDateEdit;
    CurrencyEditFin: TCurrencyEdit;
    Label2: TLabel;
    Label3: TLabel;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    Label4: TLabel;
    EditComment: TEdit;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  end;

var
  NewPayFromMaxInsurForm: TNewPayFromMaxInsurForm;

implementation

{$R *.DFM}

uses DataUnit, ListMaxInsurUnit;

procedure TNewPayFromMaxInsurForm.CMDialogKey(var Message: TCMDialogKey);
begin
// Enter to Tab
  with Message do
  begin
   case CharCode of
        VK_RETURN:
           CharCode := VK_TAB;
   end;
  end;
  inherited;
end;

procedure TNewPayFromMaxInsurForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TNewPayFromMaxInsurForm.BitBtnSaveClick(Sender: TObject);
begin
 if CurrencyEditFin.Value=0 then
 begin
  ShowMessage('Введи Сумму');
  CurrencyEditFin.SetFocus;
  Exit;
 end;

 try
   // statements to try
 with DataModuleHM.AsaStoredProcRefrFinTreat do
 begin
     DataModuleHM.AsaSessionHM.StartTransaction;
     ParamByName('@FinTreatNum').Clear;
     ParamByName('@MaxInsurNum').AsInteger:=DataModuleHM.AsaStoredProcListMaxInsurMaxInsurNum.Value;
     ParamByName('@PayCode').AsInteger:=100;
     ParamByName('@FinDate').AsDate:=DateEditFinDate.Date;
     ParamByName('@Finance').AsCurrency:=CurrencyEditFin.Value;
     ParamByName('@Comment').AsString:=EditComment.Text;
     ExecProc;
     DataModuleHM.AsaSessionHM.Commit;
 end;    // with
 except
   on e: Exception do
     begin
       DataModuleHM.AsaSessionHM.Rollback;
       ShowMessage('Ошибка сохранения '+e.Message);
     end;
 end;    // try/except
 Close;
end;

procedure TNewPayFromMaxInsurForm.FormActivate(Sender: TObject);
begin
  DateEditFinDate.Date:=Now;
end;

end.
