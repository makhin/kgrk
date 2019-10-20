unit DataUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  NdbBase, NdbAsa, Db, NdbBasDS, NdbAsaDS, ADSCNNCT, ADSSET, AdsData,
  AdsFunc, AdsTable, RxMemDS, IniFiles;

type
  TDataModuleHM = class(TDataModule)
    AsaSessionHM: TAsaSession;
    AsaStoredProcListMaxInsur: TAsaStoredProc;
    AsaStoredProcRefrClientAD: TAsaStoredProc;
    AsaStoredProcShowClient: TAsaStoredProc;
    AsaStoredProcListClients: TAsaStoredProc;
    DataSourceListClients: TDataSource;
    AsaStoredProcListInsurCase: TAsaStoredProc;
    DataSourceListInsurCase: TDataSource;
    AsaStoredProcListTreatment: TAsaStoredProc;
    AsaStoredProcShowInsurCase: TAsaStoredProc;
    AsaStoredProcRefrInsurCase: TAsaStoredProc;
    DataSourceMaxInsur: TDataSource;
    AsaStoredProcListFin: TAsaStoredProc;
    DataSourceListFin: TDataSource;
    AsaStoredProcRefrFin: TAsaStoredProc;
    AsaStoredProcRefrTreat: TAsaStoredProc;
    AsaStoredProcRefrMaxInsur: TAsaStoredProc;
    AsaStoredProcShowFin: TAsaStoredProc;
    AsaSQLUpdate: TAsaSQL;
    AsaStoredProcUnInsurCase: TAsaStoredProc;
    AsaStoredProcUnFin: TAsaStoredProc;
    AsaStoredProcListHospital: TAsaStoredProc;
    AsaStoredProcListIll: TAsaStoredProc;
    AsaStoredProcShowMKBDiag: TAsaStoredProc;
    AsaStoredProcListMKBDiag: TAsaStoredProc;
    DataSourceListMKBDiag: TDataSource;
    AsaStoredProcRefrHospital: TAsaStoredProc;
    AsaStoredProcShowHospital: TAsaStoredProc;
    AsaStoredProcListFinFact: TAsaStoredProc;
    AsaStoredProcListFinFactFinFactNum: TIntegerField;
    AsaStoredProcListFinFactFinFactDate: TDateField;
    AsaStoredProcListFinFactFinFactTypeName: TStringField;
    AsaStoredProcListFinFactFinance: TCurrencyField;
    AsaStoredProcListFinFactComment: TStringField;
    AsaStoredProcListFinFactContract: TStringField;
    AsaStoredProcListFinFactDateDeliver: TDateField;
    AsaStoredProcShowFinFact: TAsaStoredProc;
    AsaStoredProcShowFinFactFinFactNum: TIntegerField;
    AsaStoredProcShowFinFactFinFactDate: TDateField;
    AsaStoredProcShowFinFactFinFactTypeNum: TIntegerField;
    AsaStoredProcShowFinFactFinance: TCurrencyField;
    AsaStoredProcShowFinFactContract: TStringField;
    AsaStoredProcShowFinFactComment: TStringField;
    AsaStoredProcShowFinFactDateDeliver: TDateField;
    AsaStoredProcShowFinFactChange: TBooleanField;
    AsaStoredProcShowFinFactType: TAsaStoredProc;
    AsaStoredProcShowFinFactTypeFinFactTypeNum: TIntegerField;
    AsaStoredProcShowFinFactTypeFinFactTypeName: TStringField;
    AsaStoredProcShowFinFactTypeChange: TBooleanField;
    AsaStoredProcRefrFinFact: TAsaStoredProc;
    AsaStoredProcRefrFinFactType: TAsaStoredProc;
    DataSourceListFinFact: TDataSource;
    AsaStoredProcListFinFactType: TAsaStoredProc;
    AsaStoredProcListFinFactTypeFinFactTypeNum: TIntegerField;
    AsaStoredProcListFinFactTypeFinFactTypeName: TStringField;
    AsaStoredProcListFinFactMaxInsurName: TStringField;
    AsaStoredProcShowFinFactInsurNum: TIntegerField;
    AsaStoredProcRefrBranch: TAsaStoredProc;
    AsaStoredProcListBranch: TAsaStoredProc;
    AsaStoredProcShowBranch: TAsaStoredProc;
    AsaStoredProcShowClientClientNum: TStringField;
    AsaStoredProcShowClientClientName: TStringField;
    AsaStoredProcShowClientBirthDate: TDateField;
    AsaStoredProcShowClientPassport: TStringField;
    AsaStoredProcShowClientIndexField: TIntegerField;
    AsaStoredProcShowClientAddr: TStringField;
    AsaStoredProcShowClientInsurNum: TIntegerField;
    AsaStoredProcShowClientBeginDate: TDateField;
    AsaStoredProcShowClientTermDate: TDateField;
    AsaStoredProcShowClientComment: TStringField;
    AsaStoredProcShowClientChange: TBooleanField;
    AsaStoredProcShowClientFactoryNum: TIntegerField;
    AsaStoredProcShowInsurCaseInsurCaseNum: TIntegerField;
    AsaStoredProcShowInsurCaseTreatNum: TIntegerField;
    AsaStoredProcShowInsurCaseBeginDate: TDateField;
    AsaStoredProcShowInsurCaseEndDate: TDateField;
    AsaStoredProcShowInsurCaseChange: TBooleanField;
    AsaStoredProcShowInsurCaseComment: TStringField;
    AsaStoredProcShowInsurCaseInsurNum: TIntegerField;
    AsaStoredProcShowInsurCaseHospitalNum: TIntegerField;
    AsaStoredProcShowInsurCaseMKBDiagNum: TStringField;
    AsaStoredProcShowInsurCaseIllNum: TIntegerField;
    AsaStoredProcShowInsurCaseDocDate: TDateField;
    AsaStoredProcShowInsurCaseAkt: TStringField;
    AsaStoredProcShowInsurCaseBranchNum: TIntegerField;
    AsaStoredProcShowInsurCaseFactoryNum: TIntegerField;
    AsaStoredProcShowInsurCaseReportDate: TDateField;
    AsaStoredProcShowInsurCaseIsIndust: TBooleanField;
    AsaStoredProcShowInsurCaseMedSum: TCurrencyField;
    AsaStoredProcShowInsurCaseAddAkt: TBooleanField;
    AsaStoredProcShowInsurCaseAddMedSum: TCurrencyField;
    AsaStoredProcShowInsurCaseHealthSum: TCurrencyField;
    AsaStoredProcShowInsurCaseHealthTariff: TCurrencyField;
    AsaStoredProcShowInsurCaseDeathType: TBooleanField;
    AsaStoredProcShowFinFinNum: TIntegerField;
    AsaStoredProcShowFinPayCode: TIntegerField;
    AsaStoredProcShowFinFinDate: TDateField;
    AsaStoredProcShowFinFinance: TCurrencyField;
    AsaStoredProcShowFinOperator: TIntegerField;
    AsaStoredProcShowFinComment: TStringField;
    AsaStoredProcShowHospitalHospitalNum: TIntegerField;
    AsaStoredProcShowHospitalHospitalName: TStringField;
    AsaStoredProcShowHospitalChange: TBooleanField;
    AsaStoredProcShowBranchBranchNum: TIntegerField;
    AsaStoredProcShowBranchBranchName: TStringField;
    AsaStoredProcShowBranchHospitalNum: TIntegerField;
    AsaStoredProcShowBranchChange: TBooleanField;
    AsaStoredProcShowMKBDiagMKBDiagNum: TStringField;
    AsaStoredProcShowMKBDiagMKBDiagName: TStringField;
    AsaStoredProcListBranchBranchNum: TIntegerField;
    AsaStoredProcListBranchBranchName: TStringField;
    AsaStoredProcListTreatmentTreatNum: TIntegerField;
    AsaStoredProcListTreatmentTreatName: TStringField;
    AsaStoredProcListTreatmentChange: TBooleanField;
    AsaStoredProcListFinFinDate: TDateField;
    AsaStoredProcListFinFinance: TCurrencyField;
    AsaStoredProcListFinPayName: TStringField;
    AsaStoredProcListFinComment: TStringField;
    AsaStoredProcListHospitalHospitalNum: TIntegerField;
    AsaStoredProcListHospitalHospitalName: TStringField;
    AsaStoredProcListMKBDiagMKBDiagNum: TStringField;
    AsaStoredProcListMKBDiagMKBDiagName: TStringField;
    AsaStoredProcListIllIllNum: TIntegerField;
    AsaStoredProcListIllIllName: TStringField;
    AsaStoredProcShowMaxInsur: TAsaStoredProc;
    AsaStoredProcShowFactory: TAsaStoredProc;
    AsaStoredProcShowMaxInsurMaxInsurNum: TIntegerField;
    AsaStoredProcShowMaxInsurMaxInsurName: TStringField;
    AsaStoredProcShowMaxInsurChange: TBooleanField;
    AsaStoredProcShowFactoryFactoryNum: TIntegerField;
    AsaStoredProcShowFactoryFactoryName: TStringField;
    AsaStoredProcShowFactoryChange: TBooleanField;
    AsaStoredProcRefrFactory: TAsaStoredProc;
    AsaStoredProcListFactory: TAsaStoredProc;
    AsaStoredProcListFactoryFactoryNum: TIntegerField;
    AsaStoredProcListFactoryfactoryName: TStringField;
    AsaStoredProcShowInsurCaseMedTariff: TCurrencyField;
    AsaStoredProcShowInsurCaseMedBedDay: TCurrencyField;
    AsaStoredProcShowInsurCaseInsurLimitNum: TIntegerField;
    AsaStoredProcListInsurLimit: TAsaStoredProc;
    AsaStoredProcListInsurLimitInsurLimitNum: TIntegerField;
    AsaStoredProcListInsurLimitInsurLimitName: TStringField;
    AsaStoredProcListInsurLimitInsurLimitMoney: TCurrencyField;
    AsaStoredProcShowInsurLimit: TAsaStoredProc;
    AsaStoredProcShowInsurLimitInsurLimitNum: TIntegerField;
    AsaStoredProcShowInsurLimitInsurLimitName: TStringField;
    AsaStoredProcShowInsurLimitInsurLimitMoney: TCurrencyField;
    AsaStoredProcRefrInsurLimit: TAsaStoredProc;
    AsaStoredProcShowBranchBedDay1: TCurrencyField;
    AsaStoredProcShowBranchBedDay2: TCurrencyField;
    AsaStoredProcListBranchBedDay1: TCurrencyField;
    AsaStoredProcListBranchBedDay2: TCurrencyField;
    AsaStoredProcUnMedic: TAsaStoredProc;
    AsaStoredProcRefrMedic: TAsaStoredProc;
    AsaStoredProcListMedic: TAsaStoredProc;
    AsaStoredProcListMedicMedicNum: TIntegerField;
    AsaStoredProcListMedicInsurCaseNum: TIntegerField;
    AsaStoredProcListMedicFinance: TCurrencyField;
    AsaStoredProcListMedicComment: TStringField;
    DataSourceListMedic: TDataSource;
    AsaStoredProcShowInsurCaseTypeInsurCase: TIntegerField;
    AsaStoredProcListMedicOrderDate: TDateField;
    AsaStoredProcListMedicRecipeDate: TDateField;
    AsaStoredProcListMedicOrderNum: TStringField;
    AsaStoredProcListMedicRecipeNum: TStringField;
    AsaStoredProcListMaxInsurMaxInsurNum: TIntegerField;
    AsaStoredProcListMaxInsurMaxInsurName: TStringField;
    AsaStoredProcListMaxInsurMaxInsurMoney: TCurrencyField;
    AsaStoredProcListMaxInsurComment: TStringField;
    AsaStoredProcListMaxInsurLicname: TStringField;
    AsaStoredProcListMaxInsurMaxInsurPayment: TCurrencyField;
    AsaStoredProcShowMaxInsurMaxInsurMoney: TCurrencyField;
    AsaStoredProcShowMaxInsurComment: TStringField;
    AsaStoredProcShowMaxInsurLicNum: TIntegerField;
    AsaStoredProcShowMaxInsurMaxInsurPayment: TCurrencyField;
    AsaStoredProcListLicenses: TAsaStoredProc;
    AsaStoredProcListLicensesLicNum: TIntegerField;
    AsaStoredProcListLicensesLicName: TStringField;
    AsaStoredProcUnMaxInsur: TAsaStoredProc;
    AsaStoredProcRefrLic: TAsaStoredProc;
    AsaStoredProcListInsurCaseInsurCaseNum: TIntegerField;
    AsaStoredProcListInsurCaseTreatName: TStringField;
    AsaStoredProcListInsurCaseBeginDate: TDateField;
    AsaStoredProcListInsurCaseEndDate: TDateField;
    AsaStoredProcListInsurCaseComment: TStringField;
    AsaStoredProcListInsurCaseClientID: TIntegerField;
    AsaStoredProcListInsurCaseMKBDiagNum: TStringField;
    AsaStoredProcShowClientClientID: TIntegerField;
    AsaStoredProcShowInsurCaseClientID: TIntegerField;
    AsaStoredProcShowFinClientID: TIntegerField;
    AsaStoredProcListMaxInsurs: TCurrencyField;
    AsaStoredProcListFinMaxInsur: TAsaStoredProc;
    AsaStoredProcListFinMaxInsurFinTreatNum: TIntegerField;
    AsaStoredProcListFinMaxInsurFinDate: TDateField;
    AsaStoredProcListFinMaxInsurPayName: TStringField;
    AsaStoredProcListFinMaxInsurFinance: TCurrencyField;
    AsaStoredProcListFinMaxInsurComment: TStringField;
    AsaStoredProcRefrFinTreat: TAsaStoredProc;
    DataSourceListFinMaxInsur: TDataSource;
    AsaStoredProcUnFinTreat: TAsaStoredProc;
    AsaStoredProcListFinFactHospitalName: TStringField;
    AsaStoredProcListFinFactFactoryName: TStringField;
    AsaStoredProcShowFinFactHospitalNum: TIntegerField;
    AsaStoredProcShowFinFactFactoryNum: TIntegerField;
    AsaStoredProcShowInsurCaseAktDate: TDateField;
    AsaStoredProcShowInsurCasePayPercent: TIntegerField;
    AsaStoredProcShowClientFact: TStringField;
    AsaStoredProcShowClientTabN: TStringField;
    AsaStoredProcShowClientAccountNum: TStringField;
    AsaStoredProcShowInsurCaseDiagSum: TCurrencyField;
    AsaStoredProcShowInsurCaseDay_Amb: TIntegerField;
    AsaStoredProcShowInsurCaseTarif_Amb: TCurrencyField;
    AsaStoredProcShowInsurCaseDay_Stac: TIntegerField;
    AsaStoredProcShowInsurCaseTarif_Stac: TCurrencyField;
    AsaStoredProcShowInsurCaseDay_Reanim: TIntegerField;
    AsaStoredProcShowInsurCaseTarif_Reanim: TCurrencyField;
    AsaStoredProcShowInsurCaseTotalSum: TCurrencyField;
    AsaStoredProcListInsurCaseMKBDiagName: TStringField;
    AsaStoredProcShowMaxInsurStacMoney: TCurrencyField;
    AsaStoredProcShowMaxInsurAmbMoney: TCurrencyField;
    AsaStoredProcGetSumTotalSum: TAsaStoredProc;
    AsaStoredProcListClientsClientID: TIntegerField;
    AsaStoredProcListClientsClientNum: TStringField;
    AsaStoredProcListClientsClientName: TStringField;
    AsaStoredProcListClientsBirthDate: TDateField;
    AsaStoredProcListClientsFact: TStringField;
    AsaStoredProcListClientsTabN: TStringField;
    AsaStoredProcListClientsPassport: TStringField;
    AsaStoredProcListClientsIndexField: TIntegerField;
    AsaStoredProcListClientsAddr: TStringField;
    AsaStoredProcListClientsFactoryName: TStringField;
    AsaStoredProcListClientsFactoryNum: TIntegerField;
    AsaStoredProcListClientsAccountNum: TStringField;
    AsaStoredProcListClientsInsurNum: TIntegerField;
    AsaStoredProcListClientsMaxInsurName: TStringField;
    AsaStoredProcListClientsBeginDate: TDateField;
    AsaStoredProcListClientsTermDate: TDateField;
    AsaStoredProcListInsurCaseHospitalName: TStringField;
    AsaStoredProcGetLimit: TAsaStoredProc;
    AsaStoredProcRefrLimit: TAsaStoredProc;
    AsaStoredProcGetLimitLimit: TCurrencyField;
    AsaStoredProcGetLimitMedLimit: TCurrencyField;
    AsaStoredProcGetLimitServLimit: TCurrencyField;
    AsaStoredProcGetSumTotalSumTotalSum: TCurrencyField;
    AsaStoredProcGetSumTotalSumMedSum: TCurrencyField;
    AsaStoredProcGetSumTotalSumServSum: TCurrencyField;
    AsaStoredProcRemainders: TAsaStoredProc;
    AsaStoredProcRemaindersTreatNum: TIntegerField;
    AsaStoredProcRemaindersTreatName: TStringField;
    AsaStoredProcRemaindersLimit: TCurrencyField;
    AsaStoredProcRemaindersMedLimit: TCurrencyField;
    AsaStoredProcRemaindersServLimit: TCurrencyField;
    AsaStoredProcRemainderstotal: TCurrencyField;
    AsaStoredProcRemaindersmed: TCurrencyField;
    AsaStoredProcRemaindersserv: TCurrencyField;
    DataSourceRemainders: TDataSource;
    AsaStoredProcListClientsHealth: TIntegerField;
    AsaStoredProcListClientsPayHealth: TCurrencyField;
    AsaStoredProcListClientsMedCountStac: TIntegerField;
    AsaStoredProcListClientsMedCountAmb: TIntegerField;
    AsaStoredProcListClientsMedCountEmerg: TIntegerField;
    AsaStoredProcListClientsMedMedStac: TCurrencyField;
    AsaStoredProcListClientsMedMedStacDS0: TCurrencyField;
    AsaStoredProcListClientsMedMedStacDS1: TCurrencyField;
    AsaStoredProcListClientsMedMedAmb: TCurrencyField;
    AsaStoredProcListClientsMedMedEmerg: TCurrencyField;
    AsaStoredProcListClientsPayMedStac: TCurrencyField;
    AsaStoredProcListClientsPayMedAmb: TCurrencyField;
    AsaStoredProcListClientsPayMedEmerg: TCurrencyField;
    AsaStoredProcListDS: TAsaStoredProc;
    AsaStoredProcListDSDSName: TStringField;
    AsaStoredProcRefrDS: TAsaStoredProc;
    AsaStoredProcListClientsComment: TStringField;
    AsaStoredProcShowInsurCaseCorporateLimit: TBooleanField;
    AsaStoredProcShowClientCardNum: TStringField;
    procedure DataModuleDMKCreate(Sender: TObject);
    procedure DataSourceListInsurCaseDataChange(Sender: TObject;
      Field: TField);
    procedure AsaStoredProcListClientsAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    LocCode:integer;
    Operator:integer;
    PrintInsurCase:string
  end;

var
  DataModuleHM: TDataModuleHM;

implementation

{$R *.DFM}
uses ListInsurUnit;

procedure TDataModuleHM.DataModuleDMKCreate(Sender: TObject);
begin
  with TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) do
  begin
    with AsaSessionHM do
    begin
      Connected:=False;
      ClientParams:=ReadString('ASA','ClientParams','');
      LibraryFile:=ReadString('ASA','LibraryFile','');
      LoginDatabase:=ReadString('ASA','LoginDatabase','');
      LoginEngineName:=ReadString('ASA','LoginEngineName','');
    end;    // with
    LocCode:=ReadInteger('System', 'LocCode',1);
    Operator:=ReadInteger('System', 'Operator',1);
    PrintInsurCase:=ReadString('Print','InsurCase','InsurCase.frf');
  end;    // with
end;

procedure TDataModuleHM.DataSourceListInsurCaseDataChange(Sender: TObject;
  Field: TField);
begin
{
     if ((Operator<10) and (not AsaStoredProcListInsurCaseEndDate.IsNull)) then
        begin
            ListInsurForm.ButtonEdit.Enabled := False;
            ListInsurForm.ButtonDel.Enabled := False;
        end
     else
        begin
            ListInsurForm.ButtonEdit.Enabled := true;
            ListInsurForm.ButtonDel.Enabled := True;
        end
}
end;

procedure TDataModuleHM.AsaStoredProcListClientsAfterScroll(
  DataSet: TDataSet);
begin
  with DataModuleHM.AsaStoredProcRemainders do
  begin
    Close;
    ParamByName('@ClientID').Value:= AsaStoredProcListClientsClientID.Value;
    ParamByName('@InsurNum').Value:=AsaStoredProcListClientsInsurNum.Value;
    Open;
  end;    // with
end;

end.
