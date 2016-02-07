unit NewAutoPayUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, adscnnct, Db, adsdata, adsfunc, adstable, FileUtil,
  NdbBasDS, NdbAsaDS, ComCtrls, Mask, ToolEdit, HyperStr;

type
  TNewAutoPayForm = class(TForm)
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    Label7: TLabel;
    ComboBoxFactory: TComboBox;
    Label1: TLabel;
    ComboBoxMaxInsur: TComboBox;
    Label2: TLabel;
    EditScriptFile: TEdit;
    ButtonScriptFind: TButton;
    Label3: TLabel;
    EditBaseFile: TEdit;
    ButtonBaseFile: TButton;
    OpenDialog: TOpenDialog;
    AdsConnectionFactory: TAdsConnection;
    AdsQueryFactory: TAdsQuery;
    AsaStoredProcGetClientID: TAsaStoredProc;
    ProgressBar: TProgressBar;
    Label4: TLabel;
    Label5: TLabel;
    DateEditPayDate: TDateEdit;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonScriptFindClick(Sender: TObject);
    procedure ButtonBaseFileClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewAutoPayForm: TNewAutoPayForm;

implementation

uses DataUnit, InsNewClientUnit;

{$R *.DFM}

procedure TNewAutoPayForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TNewAutoPayForm.FormCreate(Sender: TObject);
begin
  OpenDialog.InitialDir:=ExtractFileDir(Application.ExeName)+'\Factory';
  AdsConnectionFactory.ConnectPath:=ExtractFileDir(Application.ExeName)+'\Factory';
end;

procedure TNewAutoPayForm.ButtonScriptFindClick(Sender: TObject);
begin
  with OpenDialog do
  begin
    Title:='Выберите файл скрипта';
    DefaultExt:='sql';
    Filter:='Файлы скриптов|*.SQL';
    if Execute then
      EditScriptFile.Text:=FileName;
  end;    // with
end;

procedure TNewAutoPayForm.ButtonBaseFileClick(Sender: TObject);
begin
  with OpenDialog do
  begin
    Title:='Выберите файл с базой платежей';
    DefaultExt:='dbf';
    Filter:='Файлы баз|*.dbf';
    if Execute then
      EditBaseFile.Text:=FileName;
  end;    // with
end;

procedure TNewAutoPayForm.BitBtnSaveClick(Sender: TObject);
var MaxInsurNum, FactoryNum, ClientID:Integer;
begin
  if ComboBoxFactory.Text='' then
    begin
      ShowMessage ('Заполните предприятие');
      ComboBoxFactory.SetFocus;
      Exit;
    end;
  if ComboBoxMaxInsur.Text='' then
    begin
      ShowMessage ('Заполните договор');
      ComboBoxMaxInsur.SetFocus;
      Exit;
    end;
    if EditScriptFile.Text='' then
    begin
      ShowMessage ('Выберите скрипт');
      ButtonScriptFind.SetFocus;
      Exit;
    end;
    if EditBaseFile.Text='' then
    begin
      ShowMessage ('Выберите базу');
      ButtonBaseFile.SetFocus;
      Exit;
    end;
  CopyFile(EditBaseFile.Text, ExtractFileDir(Application.ExeName)+'\Factory\TempDBF.dbf',nil);
  AdsQueryFactory.SQL.LoadFromFile(EditScriptFile.Text);
  AdsConnectionFactory.IsConnected:=True;
  AdsQueryFactory.Open;
  ProgressBar.Max:=AdsQueryFactory.RecordCount;

  FactoryNum:=Integer(ComboBoxFactory.Items.Objects[ComboBoxFactory.ItemIndex]);
  MaxInsurNum:=Integer(ComboBoxMaxInsur.Items.Objects[ComboBoxMaxInsur.ItemIndex]);

  while not AdsQueryFactory.EOF do
  begin
    Label4.Caption:=AdsQueryFactory.FieldByName('ClientName').AsString;
    with AsaStoredProcGetClientID do
    begin
      ParamByName('@ClientID').Clear;
      ParamByName('@MaxInsurNum').AsInteger:=MaxInsurNum;
      ParamByName('@FactoryNum').AsInteger:=FactoryNum;
      ParamByName('@ClientNum').AsString:=AdsQueryFactory.FieldByName('ClientNum').AsString;
      ParamByName('@Fact').AsString:=AdsQueryFactory.FieldByName('Fact').AsString;
      ParamByName('@TabN').AsString:=AdsQueryFactory.FieldByName('TabN').AsString;
      ExecProc;
      if ParamByName('@ClientID').IsNull then
         ClientID:=-1
      else
         ClientID:=ParamByName('@ClientID').AsInteger;
    end;    // with

    try
    with DataModuleHM.AsaStoredProcRefrClientAD do
     begin
         DataModuleHM.AsaSessionHM.StartTransaction;
         ParamByName('@ClientID').AsInteger:=ClientID;
         ParamByName('@ClientNum').AsString:=AdsQueryFactory.FieldByName('ClientNum').AsString;
         ParamByName('@ClientName').AsString:=AdsQueryFactory.FieldByName('ClientName').AsString;
         if AdsQueryFactory.FieldByName('BirthDate').AsDateTime<>EncodeDate(1900,1,1) then
          ParamByName('@BirthDate').AsDate:=AdsQueryFactory.FieldByName('BirthDate').AsDateTime
         else
          ParamByName('@BirthDate').Clear;
         ParamByName('@Fact').AsString:=AdsQueryFactory.FieldByName('Fact').AsString;
         ParamByName('@TabN').AsString:=AdsQueryFactory.FieldByName('TabN').AsString;
         ParamByName('@Passport').AsString:=AdsQueryFactory.FieldByName('Passport').AsString;
         ParamByName('@IndexField').AsInteger:=AdsQueryFactory.FieldByName('IndexField').AsInteger;
         ParamByName('@Addr').AsString:=AdsQueryFactory.FieldByName('Addr').AsString;
         ParamByName('@AccountNum').AsString:=AdsQueryFactory.FieldByName('AccountNum').AsString;
         ParamByName('@InsurNum').AsInteger:=MaxInsurNum;
         ParamByName('@FactoryNum').AsInteger:=FactoryNum;
         if AdsQueryFactory.FieldByName('BeginDate').AsDateTime<>EncodeDate(1900,1,1) then
          ParamByName('@BeginDate').AsDate:=AdsQueryFactory.FieldByName('BeginDate').AsDateTime
         else
          ParamByName('@BeginDate').Clear;
         if AdsQueryFactory.FieldByName('TermDate').AsDateTime<>EncodeDate(1900,1,1) then
          ParamByName('@TermDate').AsDate:=AdsQueryFactory.FieldByName('TermDate').AsDateTime
         else
          ParamByName('@TermDate').Clear;
         ParamByName('@Comment').AsString:=AdsQueryFactory.FieldByName('Comment').AsString;
         ParamByName('@LocCode').AsInteger:=DataModuleHM.LocCode;
         ExecProc;
         ClientID:=ParamByName('@ClientID').AsInteger;
         DataModuleHM.AsaSessionHM.Commit;
     end;    // with
     except
       on e: Exception do
        begin
          DataModuleHM.AsaSessionHM.Rollback;
          ShowMessage('Ошибка сохранения '+e.Message);
        end;
     end;    // try/except

     if AdsQueryFactory.FieldByName('Finance').AsCurrency<>0 then
     try
       // statements to try
     with DataModuleHM.AsaStoredProcRefrFin do
     begin
         DataModuleHM.AsaSessionHM.StartTransaction;
         ParamByName('@FinNum').Clear;
         ParamByName('@Comment').Clear;
         ParamByName('@LocCode').AsInteger:=DataModuleHM.LocCode;
         ParamByName('@Operator').AsInteger:=DataModuleHM.Operator;
         ParamByName('@FinDate').AsDate:=DateEditPayDate.Date;
         ParamByName('@Finance').AsCurrency:=AdsQueryFactory.FieldByName('Finance').AsCurrency;
         ParamByName('@ClientID').AsInteger:=ClientID;
         ParamByName('@PayCode').AsInteger:=1;
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
    AdsQueryFactory.Next;
    ProgressBar.StepIt;
    Application.ProcessMessages;
  end;    // while
  AdsQueryFactory.Close;
  AdsConnectionFactory.IsConnected:=False;
  Close;
end;

procedure TNewAutoPayForm.FormActivate(Sender: TObject);
begin
  ComboBoxFactory.Text:='';
  InsNewClientForm.FillComboFactory;
  ComboBoxFactory.Items.Assign(InsNewClientForm.ComboBoxFactory.Items);

  ComboBoxMaxInsur.Text:='';
  InsNewClientForm.FillComboInsur;
  ComboBoxMaxInsur.Items.Assign(InsNewClientForm.ComboBoxMaxInsur.Items);

  ProgressBar.Position:=0;

  DateEditPayDate.Date:=Now();
end;

end.
