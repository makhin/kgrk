unit InsNewFinUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, ToolEdit, CurrEdit, StdCtrls, Buttons;

type
  TInsFinForm = class(TForm)
    CurrencyEditFin: TCurrencyEdit;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    DateEditRecipe: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditComment: TEdit;
    EditRecipe: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    DateEditOrder: TDateEdit;
    Label6: TLabel;
    EditOrder: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MedicNum:integer;
    InsurCaseNum:Integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  end;

var
  InsFinForm: TInsFinForm;

implementation

uses DataUnit, MainFormUnit, InsNewHealthMedicUnit;
{$R *.DFM}

procedure TInsFinForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TInsFinForm.FormActivate(Sender: TObject);
begin
 CurrencyEditFin.Value:=0;
 DateEditOrder.Date:=Now;
 DateEditrecipe.Date:=Now;
end;

procedure TInsFinForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TInsFinForm.BitBtnSaveClick(Sender: TObject);
begin
   with DataModuleHM.AsaStoredProcRefrMedic do
   begin
    try
      // statements to try
     DataModuleHM.AsaSessionHM.StartTransaction;
     ParamByName('@LocCode').Value:=DataModuleHM.LocCode;
     ParamByName('@OrderDate').Value:=DateEditOrder.Date;
     ParamByName('@RecipeDate').Value:=DateEditRecipe.Date;
     ParamByName('@OrderNum').Value:=EditOrder.Text;
     ParamByName('@RecipeNum').Value:=EditRecipe.Text;
     ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
     ParamByName('@Finance').Value:=CurrencyEditFin.Value;
     ParamByName('@Comment').Value:=EditComment.Text;
     ExecProc;
     MedicNum:=ParamByName('@MedicNum').Value;
     DataModuleHM.AsaSessionHM.Commit;
     except
      on e: Exception do
       begin
        DataModuleHM.AsaSessionHM.Rollback;
        ShowMessage('Ошибка '+e.Message);
       end;
    end;    // try/except
   end;

end;

end.
