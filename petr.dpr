program petr;

uses
  Forms,
  Dialogs,
  SysUtils,
  LibUnit in 'LibUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  DataUnit in 'DataUnit.pas' {DataModuleHM: TDataModule},
  ImpExUnit in 'ImpExUnit.pas' {ImportExportModule: TDataModule},
  AboutUnit in 'AboutUnit.pas' {AboutBox},
  InsNewClientUnit in 'InsNewClientUnit.pas' {InsNewClientForm},
  FactoryUnit in 'FactoryUnit.pas' {FactoryForm},
  ReportUnit in 'ReportUnit.pas' {ReportModuleHM: TDataModule},
  SplashFormUnit in 'SplashFormUnit.pas' {SplashForm},
  ListClientUnit in 'ListClientUnit.pas' {ListClientForm},
  ListFinUnit in 'ListFinUnit.pas' {ListFinForm},
  ExpManUnit in 'ExpManUnit.pas' {ExpManForm},
  ListInsurUnit in 'ListInsurUnit.pas' {ListInsurForm},
  HospitalUnit in 'HospitalUnit.pas' {HospitalForm},
  ListMKBUnit in 'ListMKBUnit.pas' {ListMKBDiagForm},
  InsNewHealthMedicUnit in 'InsNewHealthMedicUnit.pas' {InsNewHealthMedicForm},
  InsNewMedUnit in 'InsNewMedUnit.pas' {InsNewMedForm},
  BranchUnit in 'BranchUnit.pas' {BranchForm},
  InsNewHealthUnit in 'InsNewHealthUnit.pas' {InsNewHealthForm},
  InsNewFinUnit in 'InsNewFinUnit.pas' {InsFinForm},
  ListFinFactUnit in 'ListFinFactUnit.pas' {ListFinFactForm},
  InsNewFinFactUnit in 'InsNewFinFactUnit.pas' {InsNewFinFactForm},
  FinFactTypeUnit in 'FinFactTypeUnit.pas' {FinFactTypeForm},
  ListMaxInsurUnit in 'ListMaxInsurUnit.pas' {ListMaxInsurForm},
  InsNewMaxInsurUnit in 'InsNewMaxInsurUnit.pas' {MaxInsurForm},
  InsNewLicUnit in 'InsNewLicUnit.pas' {NewLicForm},
  ListFinMaxInsurUnit in 'ListFinMaxInsurUnit.pas' {ListFinMaxInsurForm},
  NewPayFromMaxInsurUnit in 'NewPayFromMaxInsurUnit.pas' {NewPayFromMaxInsurForm},
  NewAutoPayUnit in 'NewAutoPayUnit.pas' {NewAutoPayForm},
  InsNewInsurUnit in 'InsNewInsurUnit.pas' {InsNewInsurForm},
  InsNewOrderUnit in 'InsNewOrderUnit.pas' {InsOrderForm},
  InsNewInOutUnit in 'InsNewInOutUnit.pas' {InsInOutForm},
  MedicalUnit in 'MedicalUnit.pas' {MedicalForm},
  ListInOutUnit in 'ListInOutUnit.pas' {InOutListForm},
  ListStockFromNameUnit in 'ListStockFromNameUnit.pas' {ListStockFromNameForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Медицина и Здоровье';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDataModuleHM, DataModuleHM);
  try
   DataModuleHM.AsaSessionHM.LoginPassword:=InputPassword('Здоровье и медицина', 'Введите пароль');
   DataModuleHM.AsaSessionHM.Connected:=True;
   DataModuleHM.AsaSQLUpdate.ExecuteImmediate('SETUSER DBA');
  except // wrap up
   ShowMessage ('Не могу соединиться с сервером');
   Exit;
  end;    // try/finally

  SplashForm:=TSplashForm.Create(Application);
  CurrencyString:='';
  SplashForm.Show;
  SplashForm.Update;
  Application.CreateForm(TInsNewInsurForm, InsNewInsurForm);
  Application.CreateForm(TInsOrderForm, InsOrderForm);
  Application.CreateForm(TInsInOutForm, InsInOutForm);
  Application.CreateForm(TMedicalForm, MedicalForm);
  Application.CreateForm(TInOutListForm, InOutListForm);
  Application.CreateForm(TListStockFromNameForm, ListStockFromNameForm);
  Application.CreateForm(TImportExportModule, ImportExportModule);
  Application.CreateForm(TNewAutoPayForm, NewAutoPayForm);
  Application.CreateForm(TReportModuleHM, ReportModuleHM);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TInsNewClientForm, InsNewClientForm);
  Application.CreateForm(TFactoryForm, FactoryForm);
  Application.CreateForm(TListClientForm, ListClientForm);
  Application.CreateForm(TListFinForm, ListFinForm);
  Application.CreateForm(TExpManForm, ExpManForm);
  Application.CreateForm(TListInsurForm, ListInsurForm);
  Application.CreateForm(THospitalForm, HospitalForm);
  Application.CreateForm(TListMKBDiagForm, ListMKBDiagForm);
  Application.CreateForm(TInsNewHealthMedicForm, InsNewHealthMedicForm);
  Application.CreateForm(TInsNewMedForm, InsNewMedForm);
  Application.CreateForm(TBranchForm, BranchForm);
  Application.CreateForm(TInsNewHealthForm, InsNewHealthForm);
  Application.CreateForm(TInsFinForm, InsFinForm);
  Application.CreateForm(TListFinFactForm, ListFinFactForm);
  Application.CreateForm(TInsNewFinFactForm, InsNewFinFactForm);
  Application.CreateForm(TFinFactTypeForm, FinFactTypeForm);
  Application.CreateForm(TListMaxInsurForm, ListMaxInsurForm);
  Application.CreateForm(TMaxInsurForm, MaxInsurForm);
  Application.CreateForm(TNewLicForm, NewLicForm);
  Application.CreateForm(TListFinMaxInsurForm, ListFinMaxInsurForm);
  Application.CreateForm(TNewPayFromMaxInsurForm, NewPayFromMaxInsurForm);
  SplashForm.Hide;
  SplashForm.Free;
  Application.Run;
end.
