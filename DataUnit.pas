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
    AsaStoredProcListMaxInsurComment: TStringField;
    AsaStoredProcListMaxInsurLicname: TStringField;
    AsaStoredProcShowMaxInsurComment: TStringField;
    AsaStoredProcShowMaxInsurLicNum: TIntegerField;
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
    AsaStoredProcGetLimitLimit: TCurrencyField;
    AsaStoredProcGetLimitMedLimit: TCurrencyField;
    AsaStoredProcGetLimitServLimit: TCurrencyField;
    AsaStoredProcRemainders: TAsaStoredProc;
    DataSourceRemainders: TDataSource;
    AsaStoredProcListTreatmentTreatMoney: TCurrencyField;
    AsaStoredProcListStockFromName: TAsaStoredProc;
    AsaStoredProcListStockFromNameProdCode: TStringField;
    AsaStoredProcListStockFromNameProdName: TStringField;
    AsaStoredProcListStockFromNameCost: TCurrencyField;
    AsaStoredProcListStockFromNameCurr_Stock: TFloatField;
    DataSourceListStockFromName: TDataSource;
    AsaStoredProcListOrder_s: TAsaStoredProc;
    AsaStoredProcListOrder_sOrderNum: TIntegerField;
    AsaStoredProcListOrder_sOrderDate: TDateField;
    AsaStoredProcListOrder_sInsurCaseNum: TIntegerField;
    AsaStoredProcListOrder_sOperator: TIntegerField;
    AsaStoredProcListOrder_sComment: TStringField;
    AsaStoredProcListOrder_sTotalSale: TCurrencyField;
    AsaStoredProcListOrder_sPaid: TBooleanField;
    DataSourceListOrder_s: TDataSource;
    AsaStoredProcListOrder_d: TAsaStoredProc;
    AsaStoredProcListOrder_dID: TIntegerField;
    AsaStoredProcListOrder_dOrderNum: TIntegerField;
    AsaStoredProcListOrder_dProdCode: TStringField;
    AsaStoredProcListOrder_dQuantity: TFloatField;
    AsaStoredProcListOrder_dTotalSale: TCurrencyField;
    AsaStoredProcListOrder_dCost: TCurrencyField;
    AsaStoredProcListOrder_dProdName: TStringField;
    DataSourceListOrder_d: TDataSource;
    AsaStoredProcListInOut_s: TAsaStoredProc;
    AsaStoredProcListInOut_sInOutNum: TIntegerField;
    AsaStoredProcListInOut_sInOutDate: TDateField;
    AsaStoredProcListInOut_sOperator: TIntegerField;
    AsaStoredProcListInOut_sComment: TStringField;
    AsaStoredProcListInOut_sTotalSale: TCurrencyField;
    DataSourceListInOut_s: TDataSource;
    AsaStoredProcListinOut_d: TAsaStoredProc;
    AsaStoredProcListinOut_dID: TIntegerField;
    AsaStoredProcListinOut_dInOutNum: TIntegerField;
    AsaStoredProcListinOut_dProdCode: TStringField;
    AsaStoredProcListinOut_dQuantity: TFloatField;
    AsaStoredProcListinOut_dTotalSale: TCurrencyField;
    AsaStoredProcListinOut_dCost: TCurrencyField;
    AsaStoredProcListinOut_dProdName: TStringField;
    DataSourceListInOut_d: TDataSource;
    RxMemoryDataInOut_d: TRxMemoryData;
    RxMemoryDataInOut_dProdCode: TStringField;
    RxMemoryDataInOut_dProdName: TStringField;
    RxMemoryDataInOut_dCost: TCurrencyField;
    RxMemoryDataInOut_dTotalSale: TCurrencyField;
    RxMemoryDataInOut_dQuantity: TFloatField;
    RxMemoryDataOrder_d: TRxMemoryData;
    RxMemoryDataOrder_dProdCode: TStringField;
    RxMemoryDataOrder_dProdName: TStringField;
    RxMemoryDataOrder_dCost: TCurrencyField;
    RxMemoryDataOrder_dTotalSale: TCurrencyField;
    RxMemoryDataOrder_dQuantity: TFloatField;
    DataSourceInOut_d: TDataSource;
    DataSourceOrder_d: TDataSource;
    AsaStoredProcListProduct: TAsaStoredProc;
    AsaStoredProcListProductProdCode: TStringField;
    AsaStoredProcListProductProdName: TStringField;
    AsaStoredProcRefrInOut_s: TAsaStoredProc;
    AsaStoredProcRefrInOut_d: TAsaStoredProc;
    AsaStoredProcRefrOrder_s: TAsaStoredProc;
    AsaStoredProcRefrOrder_d: TAsaStoredProc;
    AsaStoredProcListCostStock: TAsaStoredProc;
    AsaStoredProcListCostStockCost: TCurrencyField;
    AsaStoredProcListCostStockCurr_Stock: TFloatField;
    DataSourceCostStock: TDataSource;
    AsaStoredProcExistProdCode: TAsaStoredProc;
    AsaStoredProcUnOrder: TAsaStoredProc;
    AsaStoredProcRefrProduct: TAsaStoredProc;
    AsaStoredProcShowProduct: TAsaStoredProc;
    AsaStoredProcShowProductProdCode: TStringField;
    AsaStoredProcShowProductProdName: TStringField;
    AsaStoredProcShowProductBox: TIntegerField;
    AsaStoredProcShowProductProducer: TStringField;
    AsaStoredProcShowProductChange: TBooleanField;
    AsaStoredProcEP: TAsaStoredProc;
    AsaStoredProcShowOrder: TAsaStoredProc;
    AsaStoredProcShowOrderOrderNum: TIntegerField;
    AsaStoredProcShowOrderOrderDate: TDateField;
    AsaStoredProcShowOrderInsurCaseNum: TIntegerField;
    AsaStoredProcShowOrderOperator: TIntegerField;
    AsaStoredProcShowOrderComment: TStringField;
    AsaStoredProcShowOrderTotalSale: TCurrencyField;
    AsaStoredProcShowOrder_d: TAsaStoredProc;
    AsaStoredProcShowOrder_dprodcode: TStringField;
    AsaStoredProcShowOrder_dprodname: TStringField;
    AsaStoredProcShowOrder_dcost: TCurrencyField;
    AsaStoredProcShowOrder_dquantity: TFloatField;
    AsaStoredProcShowInsurCaseTreatName: TStringField;
    AsaStoredProcShowInsurCaseTreatMoney: TCurrencyField;
    AsaStoredProcShowInsurCaseSickList: TStringField;
    AsaStoredProcShowInsurCasePeriod: TIntegerField;
    AsaStoredProcShowInsurCaseTotalSale: TCurrencyField;
    AsaStoredProcShowInsurCaseDebt: TCurrencyField;
    AsaDatasetMedic: TAsaDataset;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    StringField3: TStringField;
    BooleanField1: TBooleanField;
    DataSourceMedic: TDataSource;
    AsaStoredProcRemaindersProgramName: TStringField;
    AsaStoredProcRemaindersProgramLimit: TCurrencyField;
    AsaStoredProcRemaindersRest: TCurrencyField;
    AsaStoredProcGetSumTotalSumLimit: TCurrencyField;
    AsaStoredProcGetSumTotalSumTreatLimit: TCurrencyField;
    AsaStoredProcGetSumTotalSumTotalSum: TCurrencyField;
    AsaStoredProcGetSumTotalSumProgName: TStringField;
    AsaStoredProcExistProdCodeCurr_Stock: TFloatField;
    AsaStoredProcListClientsMSCHCount: TIntegerField;
    AsaStoredProcListClientsMSCHSum: TCurrencyField;
    AsaStoredProcListClientsMedCount: TIntegerField;
    AsaStoredProcListClientsMedMedSum: TCurrencyField;
    AsaStoredProcListClientsMedLPUSum: TCurrencyField;
    AsaStoredProcListClientsHealthCount: TIntegerField;
    AsaStoredProcListClientsHealthSum: TCurrencyField;
    procedure DataModuleDMKCreate(Sender: TObject);
    procedure DataSourceListInsurCaseDataChange(Sender: TObject;
      Field: TField);
    procedure AsaStoredProcListClientsAfterScroll(DataSet: TDataSet);
    procedure RxMemoryDataOrder_dCalcFields(DataSet: TDataSet);
    procedure RxMemoryDataInOut_dCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    LocCode:integer;
    Operator:integer;
    PrintOrder, PrintInOut, PrintInsurCase:string;
    NativeHospitalNum:Integer;
    ReducePercent, ReducePercentLPU:Integer;
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
    PrintOrder:=ReadString('Print','Order','Order.frf');
    PrintInOut:=ReadString('Print','InOut','InOut.frf');
    PrintInsurCase:=ReadString('Print','InsurCase','InsurCase.frf');
    NativeHospitalNum:=ReadInteger('System', 'NativeHospitalNum',1);
    ReducePercent:=ReadInteger('System', 'ReducePercent',15);
    ReducePercentLPU:=ReadInteger('System', 'ReducePercentLPU',7);
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

procedure TDataModuleHM.RxMemoryDataOrder_dCalcFields(DataSet: TDataSet);
begin
        RxMemoryDataOrder_dTotalSale.Value:=RxMemoryDataOrder_dCost.Value*RxMemoryDataOrder_dQuantity.Value
end;

procedure TDataModuleHM.RxMemoryDataInOut_dCalcFields(DataSet: TDataSet);
begin
        RxMemoryDataInOut_dTotalSale.Value:=RxMemoryDataInOut_dCost.Value*RxMemoryDataInOut_dQuantity.Value
end;

end.
