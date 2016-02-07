unit ReportUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DataUnit,
  FR_DCtrl, FR_ASADB, FR_Class, FR_Desgn, FR_Cross, frOLEExl, frRtfExp,
  frHTMExp, frexpimg, frTXTExp, frXMLExl, FR_E_CSV, FR_E_RTF, FR_E_TXT,
  FR_RRect, FR_Shape, FR_ChBox, FR_RxRTF, FR_DSet, FR_DBSet, FR_DBLookupCtl, fr_DBNewLookup;
type
  TMyFunctionLibrary = class(TfrFunctionLibrary)
  public
    constructor Create; override;
    procedure DoFunction(FNo: Integer; p1, p2, p3: Variant;
      var val: Variant); override;
  end;

  TReportModuleHM = class(TDataModule)
    frReport: TfrReport;
    frASAComponents: TfrASAComponents;
    frDesigner: TfrDesigner;
    OpenDialogReport: TOpenDialog;
    frCrossObject: TfrCrossObject;
    frOLEExcelExport: TfrOLEExcelExport;
    frRtfAdvExport: TfrRtfAdvExport;
    frCheckBoxObject: TfrCheckBoxObject;
    frShapeObject: TfrShapeObject;
    frRoundRectObject: TfrRoundRectObject;
    frTextExport: TfrTextExport;
    frRTFExport: TfrRTFExport;
    frCSVExport: TfrCSVExport;
    frXMLExcelExport1: TfrXMLExcelExport;
    frTextAdvExport: TfrTextAdvExport;
    frJPEGExport: TfrJPEGExport;
    frHTMLTableExport: TfrHTMLTableExport;
    frRxRichObject: TfrRxRichObject;
    frDialogControls: TfrDialogControls;
    procedure ReportModuleHMCreate(Sender: TObject);
    procedure ReportModuleHMDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MyFuncLib:TMyFunctionLibrary;
    ReportPath:string;
    procedure PrintOrder(OrderNum:integer);
    procedure PrintInOut(InOutNum:integer);
    procedure PrintInsurCase(InsurCaseNum:Integer);
    procedure PrintUserReport;
  end;

var
  ReportModuleHM: TReportModuleHM;

implementation

uses LibUnit;
{$R *.DFM}
constructor TMyFunctionLibrary.Create;
begin
  inherited Create;
  with List do
  begin
    Add('SUMPROPIS');
    Add('QNTPROPIS');
  end;
end;

procedure TMyFunctionLibrary.DoFunction(FNo: Integer; p1, p2, p3: Variant;
  var val: Variant);
begin
  val := 0;
  case FNo of
    0: val := UAH(frParser.Calc(p1));
    1: val := QNT(frParser.Calc(p1));
  end;
end;

procedure TReportModuleHM.ReportModuleHMCreate(Sender: TObject);
begin
 ReportPath:=ExtractFileDir(Application.ExeName)+'\report\';
 frLocale.LoadDll('FR_RUS.dll');
 frReport.Dictionary.DisabledDatasets.Add('DataModuleHM*');
 frReport.Dictionary.DisabledDatasets.Add('ImportExportModule*');
 frReport.Dictionary.DisabledDatasets.Add('NewAutoPayForm*');
 OpenDialogReport.InitialDir:=ExtractFileDir(Application.ExeName)+'\report\user\';
 MyFuncLib:=TMyFunctionLibrary.Create;
 MyFuncLib.AddFunctionDesc('SUMPROPIS', 'Мои функции','SUMPROPIS(<Число>)/Возвращает сумму прописью.');
 MyFuncLib.AddFunctionDesc('QNTPROPIS', 'Мои функции','QNTPROPIS(<Число>)/Возвращает целое число прописью.');
 frRegisterFunctionLibrary(TMyFunctionLibrary);
end;

procedure TReportModuleHM.PrintOrder(OrderNum:integer);
begin
  frReport.LoadFromFile(ReportPath+DataModuleHM.PrintOrder);
  frVariables['OrderNum']:=OrderNum;
  frReport.ShowReport;
end;

procedure TReportModuleHM.PrintInOut(InOutNum:integer);
begin
  frReport.LoadFromFile(ReportPath+DataModuleHM.PrintInOut);
  frVariables['InOutNum']:=InOutNum;
  frReport.ShowReport;
end;

procedure TReportModuleHM.PrintInsurCase(InsurCaseNum:Integer);
begin
  frReport.LoadFromFile(ReportPath+DataModuleHM.PrintInsurCase);
  frVariables['InsurCaseNum']:=InsurCaseNum;
  frReport.ShowReport;
end;

procedure TReportModuleHM.PrintUserReport;
begin
  if OpenDialogReport.Execute then
  begin
    frReport.LoadFromFile(OpenDialogReport.FileName);
    frReport.ShowReport;
  end;
end;

procedure TReportModuleHM.ReportModuleHMDestroy(Sender: TObject);
begin
 frUnRegisterFunctionLibrary(TMyFunctionLibrary);
 MyFuncLib.Free;
end;

end.

