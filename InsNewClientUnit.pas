unit InsNewClientUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit;

type
  TInsNewClientForm = class(TForm)
    Label1: TLabel;
    EditClientName: TEdit;
    Label3: TLabel;
    DateEditBidthDate: TDateEdit;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    Label4: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditPassport: TEdit;
    Label7: TLabel;
    EditClientNum: TEdit;
    Label8: TLabel;
    EditAddr: TEdit;
    Label9: TLabel;
    MaskEditIndex: TMaskEdit;
    Label10: TLabel;
    EditAccount: TEdit;
    ComboBoxMaxInsur: TComboBox;
    Label11: TLabel;
    DateEditBegin: TDateEdit;
    DateEditTerm: TDateEdit;
    Label12: TLabel;
    Label13: TLabel;
    EditComment: TEdit;
    Label14: TLabel;
    ComboBoxFactory: TComboBox;
    ButtonFacAdd: TButton;
    ButtonFacEd: TButton;
    ButtonInsurAdd: TButton;
    ButtonInsurEd: TButton;
    MaskEditFact: TEdit;
    MaskEditTabN: TEdit;
    Label15: TLabel;
    EditCardNum: TEdit;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ButtonFacAddClick(Sender: TObject);
    procedure ButtonFacEdClick(Sender: TObject);
    procedure ButtonInsurAddClick(Sender: TObject);
    procedure ButtonInsurEdClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ClientID:Integer;
    InsurNum:Integer;
    FactoryNum:Integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure FillComboInsur;
    procedure FillComboFactory;
  end;

var
  InsNewClientForm: TInsNewClientForm;

implementation

uses DataUnit, InsNewMaxInsurUnit, FactoryUnit;

{$R *.DFM}

procedure TInsNewClientForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TInsNewClientForm.BitBtnCancelClick(Sender: TObject);
begin
 Close;
end;

procedure TInsNewClientForm.BitBtnSaveClick(Sender: TObject);
begin
 if EditClientName.Text='' then
 begin
  ShowMessage('Введи ФИО');
  EditClientName.SetFocus;
  Exit;
 end;

 if MaskEditFact.Text='' then
 begin
  ShowMessage('Введи Цех');
  MaskEditFact.SetFocus;
  Exit;
 end;

 if MaskEditTabN.Text='' then
 begin
  ShowMessage('Введи табельный');
  MaskEditTabN.SetFocus;
  Exit;
 end;


 try
   // statements to try
 with DataModuleHM.AsaStoredProcRefrClientAD do
 begin
     ParamByName('@ClientID').AsInteger:=ClientID;
     ParamByName('@ClientNum').AsString:=EditClientNum.Text;
     ParamByName('@ClientName').AsString:=EditClientName.Text;
     if DateEditBidthDate.Date<>0 then
      ParamByName('@BirthDate').AsDate:=DateEditBidthDate.Date
     else
      ParamByName('@BirthDate').Clear;
     ParamByName('@Fact').AsString:=MaskEditFact.Text;
     ParamByName('@TabN').AsString:=MaskEditTabN.Text;
     ParamByName('@Passport').AsString:=EditPassport.Text;
     ParamByName('@IndexField').AsString:=MaskEditIndex.Text;
     ParamByName('@Addr').AsString:=EditAddr.Text;
     ParamByName('@AccountNum').AsString:=EditAccount.Text;
     ParamByName('@CardNum').AsString:=EditCardNum.Text;
     ParamByName('@InsurNum').AsInteger:=Integer(ComboBoxMaxInsur.Items.Objects[ComboBoxMaxInsur.ItemIndex]);
     ParamByName('@FactoryNum').AsInteger:=Integer(ComboBoxFactory.Items.Objects[ComboBoxFactory.ItemIndex]);
     if DateEditBegin.Date<>0 then
      ParamByName('@BeginDate').AsDate:=DateEditBegin.Date
     else
      ParamByName('@BeginDate').Clear;
     if DateEditTerm.Date<>0 then
      ParamByName('@TermDate').AsDate:=DateEditTerm.Date
     else
      ParamByName('@TermDate').Clear;
     ParamByName('@Comment').AsString:=EditComment.Text;
     ParamByName('@LocCode').AsInteger:=DataModuleHM.LocCode;
     ExecProc;
 end;    // with
 except
   on e: Exception do
     ShowMessage('Ошибка сохранения '+e.Message);
 end;    // try/except
 Close;
end;

procedure TInsNewClientForm.FormActivate(Sender: TObject);
begin
 FillComboInsur;
 FillComboFactory;

 with DataModuleHM.AsaStoredProcShowClient do
 begin
   ParamByName('@ClientID').Value:=ClientID;
   Open;
   EditClientNum.Text:=FieldByName('ClientNum').AsString;
   EditClientName.Text:=FieldByName('ClientName').AsString;
   DateEditBidthDate.Date:=FieldByName('BirthDate').AsDateTime;
   MaskEditFact.Text:=FieldByName('Fact').AsString;
   MaskEditTabN.Text:=FieldByName('TabN').AsString;
   EditPassport.Text:=FieldByName('Passport').AsString;
   EditAddr.Text:=FieldByName('Addr').AsString;
   MaskEditIndex.Text:=FieldByName('IndexField').AsString;
   EditAccount.Text:=FieldByName('AccountNum').AsString;
   EditCardNum.Text:=FieldByName('CardNum').AsString;
   DateEditBegin.Date:=FieldByName('BeginDate').AsDateTime;
   DateEditTerm.Date:=FieldByName('TermDate').AsDateTime;
   EditComment.Text:=FieldByName('Comment').AsString;
   ComboBoxMaxInsur.ItemIndex:=ComboBoxMaxInsur.Items.IndexOfObject(TObject(FieldByName('InsurNum').AsInteger));
   ComboBoxFactory.ItemIndex:=ComboBoxFactory.Items.IndexOfObject(TObject(FieldByName('FactoryNum').AsInteger));
   Close;
 end;    // with
 if ClientID=-1 then
   begin
     if InsurNum=-1 then
      begin
       ComboBoxMaxInsur.ItemIndex:=0;
       ComboBoxFactory.ItemIndex:=0;
      end
     else
      begin
       ComboBoxMaxInsur.ItemIndex:=ComboBoxMaxInsur.Items.IndexOfObject(TObject(InsurNum));
       ComboBoxFactory.ItemIndex:=ComboBoxFactory.Items.IndexOfObject(TObject(FactoryNum));
      end
   end

end;

procedure TInsNewClientForm.FillComboInsur;
begin
 with DataModuleHM.AsaStoredProcListMaxInsur do
 begin
   Open;
   ComboBoxMaxInsur.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxMaxInsur.Items.AddObject(DataModuleHM.AsaStoredProcListMaxInsurMaxInsurName.AsString, TObject(DataModuleHM.AsaStoredProcListMaxInsurMaxInsurNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with

end;

procedure TInsNewClientForm.FillComboFactory;
begin
 with DataModuleHM.AsaStoredProcListFactory do
 begin
   Open;
   ComboBoxFactory.Items.Clear;
   while not Eof do
   begin
     Application.ProcessMessages;
     ComboBoxFactory.Items.AddObject(DataModuleHM.AsaStoredProcListFactoryFactoryName.AsString, TObject(DataModuleHM.AsaStoredProcListFactoryFactoryNum.asInteger));
     Next;
   end;    // while
   Close;
 end;    // with
end;

procedure TInsNewClientForm.ButtonFacAddClick(Sender: TObject);
begin
 with FactoryForm do
 begin
  FactoryNum:=-1;
  ShowModal;
 end;    // with
end;

procedure TInsNewClientForm.ButtonFacEdClick(Sender: TObject);
begin
 with FactoryForm do
 begin
  FactoryNum:=Integer(ComboBoxFactory.Items.Objects[ComboBoxFactory.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewClientForm.ButtonInsurAddClick(Sender: TObject);
begin
 with MaxInsurForm do
 begin
  MaxInsurNum:=-1;
  ShowModal;
 end;    // with
end;

procedure TInsNewClientForm.ButtonInsurEdClick(Sender: TObject);
begin
 with MaxInsurForm do
 begin
  MaxInsurNum:=Integer(ComboBoxMaxInsur.Items.Objects[ComboBoxMaxInsur.ItemIndex]);
  ShowModal;
 end;    // with
end;

procedure TInsNewClientForm.FormCreate(Sender: TObject);
begin
 FillComboInsur;
 FillComboFactory;
end;

end.
