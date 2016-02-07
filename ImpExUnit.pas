unit ImpExUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADSCNNCT, ADSSET, Db, AdsData, AdsFunc, AdsTable,  NdbBasDS,
  NdbAsaDS, NdbBase, NdbAsa, VCLUnZip, VCLZip, FilesScn, FlList, FileUtil, Menus;

type
  TImportExportModule = class(TDataModule)
    AdsTableImport: TAdsTable;
    AdsSettings: TAdsSettings;
    AdsConnectionImport: TAdsConnection;
    AdsConnectionExport: TAdsConnection;
    AdsConnectionFactory: TAdsConnection;
    AdsTableExport: TAdsTable;
    AsaStoredProcExport: TAsaStoredProc;
    AsaStoredProcListExportTable: TAsaStoredProc;
    VCLZip: TVCLZip;
    VCLUnZip: TVCLUnZip;
    AsaStoredProcRefrDataLog: TAsaStoredProc;
    AsaStoredProcEndExport: TAsaStoredProc;
    FilesScanner: TFilesScanner;
    AsaStoredProcListExportTableID: TIntegerField;
    AsaStoredProcListExportTableTableName: TStringField;
    AsaStoredProcListExportTableTableDef: TStringField;
    AsaStoredProcListExportTableStoredProcExp: TStringField;
    AsaStoredProcListExportTableLocCode: TBooleanField;
    AsaStoredProcListExportTableStoredProcImp: TStringField;
    AsaStoredProcImport: TAsaStoredProc;
    AsaStoredProcExistsExport: TAsaStoredProc;
    AdsQueryListClients: TAdsQuery;
    AsaStoredProcSetPend: TAsaStoredProc;
    AsaStoredProcChangeClientNum: TAsaStoredProc;
    AsaStoredProcLastExport: TAsaStoredProc;
    AdsTableFarmWest: TAdsTable;
    AdsQueryFWOrder: TAdsQuery;
    AdsConnectionFarmWest: TAdsConnection;
    OpenDialogFarmWest: TOpenDialog;
    procedure ImportExportDataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    f:TextFile;
  public
    { Public declarations }
     procedure CreateExport;
     procedure ExecuteImport;
     procedure NPayment(Sender:TObject);
     procedure Pend(Capt:string);
     procedure ImportFarmWestOrder(Capt:string);
  end;

var
  ImportExportModule: TImportExportModule;

implementation

{$R *.DFM}

uses  DataUnit, LibUnit, MainFormUnit;

procedure TImportExportModule.NPayment(Sender:TObject);
begin
  ImportExportModule.Pend((Sender as TMenuItem).Caption);
end;

procedure TImportExportModule.ImportExportDataModuleCreate(
  Sender: TObject);
var  j:integer;
     TempItem1, TempItem2:TMenuItem;

begin
  AdsConnectionImport.ConnectPath:=ExtractFileDir(Application.ExeName)+'\Import';
  AdsConnectionExport.ConnectPath:=ExtractFileDir(Application.ExeName)+'\Export';
  AdsConnectionFactory.ConnectPath:=ExtractFileDir(Application.ExeName)+'\Factory';
  AdsConnectionFarmWest.ConnectPath:=ExtractFileDir(Application.ExeName)+'\FarmWest';
  OpenDialogFarmWest.InitialDir:=ExtractFileDir(Application.ExeName)+'\FarmWest';

  FilesScanner.FileMask:='*.sql';
  FilesScanner.ScanDir:=AdsConnectionFarmWest.ConnectPath;
  FilesScanner.Scan;

  for j := 0 to FilesScanner.FilesCount-1 do    // Iterate
   begin
    TempItem1:=TMenuItem.Create(MainForm);
    TempItem1.Caption:=Copy(TFileObject(FilesScanner.Files.Items[j]).FileName,1, Length(TFileObject(FilesScanner.Files.Items[j]).FileName)-4);
    TempItem1.OnClick:=MainForm.NInOutFileClick;
    MainForm.NInOutFile.Add(TempItem1);
   end;


  FilesScanner.FileMask:='д*.sql';
  FilesScanner.ScanDir:=AdsConnectionFactory.ConnectPath;
  FilesScanner.Scan;

  for j := 0 to FilesScanner.FilesCount-1 do    // Iterate
   begin
    TempItem2:=TMenuItem.Create(MainForm);
    TempItem2.Caption:=Copy(TFileObject(FilesScanner.Files.Items[j]).FileName,1, Length(TFileObject(FilesScanner.Files.Items[j]).FileName)-4);
    TempItem2.OnClick:=NPayment;
    MainForm.NPayment.Add(TempItem2);
   end;
end;


procedure TImportExportModule.CreateExport;
var j:integer;
    s:string;
begin
 AsaStoredProcListExportTable.Open;
 try
   // statements to try
 DataModuleHM.AsaSessionHM.StartTransaction;
 while not AsaStoredProcListExportTable.EOF do
 begin
 AdsConnectionExport.IsConnected:=True;
 with AdsTableExport do
  begin
   AsaStoredProcExport.UnPrepare;
   AsaStoredProcExport.StoredProcName:=AsaStoredProcListExportTableStoredProcExp.Value;
   AsaStoredProcExport.Prepare;
   if AsaStoredProcListExportTableLocCode.Value then
      AsaStoredProcExport.Params[0].Value:=DataModuleHM.LocCode;
   AsaStoredProcExport.Open;

   // если не выбралось ни одной записи, то пропустить
   if AsaStoredProcExport.RecordCount=0 then
     begin
       AsaStoredProcExport.Close;
       AsaStoredProcListExportTable.Next;
       Continue;
     end;

   AdsCreateTable( AdsConnectionExport.ConnectPath+'\'+AsaStoredProcListExportTableTableName.Value, ttAdsCDX, OEM, 0,AsaStoredProcListExportTableTableDef.Value);
   TableName := AsaStoredProcListExportTableTableName.Value+'.DBF';
   Active:=True;
   MainForm.ProgressBar.Position:=0;
   MainForm.ProgressBar.Max:=AsaStoredProcExport.RecordCount;
   while not AsaStoredProcExport.EOF do
    begin
      Append;
      for j := 0 to AsaStoredProcExport.FieldCount-1 do    // Iterate
        Fields[j].Value:=AsaStoredProcExport.Fields[j].Value;
      Post;
      AsaStoredProcExport.Next;
      MainForm.ProgressBar.StepIt;
      Application.ProcessMessages;
    end;    // while
     Active:=False;
     AsaStoredProcExport.Close;
     MainForm.ProgressBar.Position:=0;
  end;
 AdsConnectionExport.IsConnected:=False;
 AsaStoredProcListExportTable.Next;
 end;    // while
 DataModuleHM.AsaSessionHM.Commit;
 except
   on e: Exception do
  begin
   ShowMessage('Ошибка экспорта '+e.Message);
   DataModuleHM.AsaSessionHM.Rollback;
   AsaStoredProcExport.Close;
   AsaStoredProcListExportTable.Close;
   Exit;
  end;
 end;    // try/except
 AsaStoredProcListExportTable.Close;

 FilesScanner.FileMask:='*.dbf';
 FilesScanner.ScanDir:=AdsConnectionExport.ConnectPath;
 FilesScanner.Scan;

 if FilesScanner.Files.Count=0 then
   begin
     ShowMessage ('Нет данных для экспорта');
     Exit;
   end;

 AsaStoredProcRefrDataLog.ParamByName('@ExportNum').Clear;
 AsaStoredProcRefrDataLog.ParamByName('@LocCode').Value:=DataModuleHM.LocCode;
 AsaStoredProcRefrDataLog.ExecProc;
 s:=AsaStoredProcRefrDataLog.ParamByName('@ExportNum').AsString;

 for j := 1 to 6-Length(s) do    // Iterate
  s:='0'+s;

 s:=IntToStr(DataModuleHM.LocCode)+s+'.zip';

 With VCLZip do
  begin
   ZipName :=AdsConnectionExport.ConnectPath+'\'+s;
   RootDir :=AdsConnectionExport.ConnectPath;
   FilesList.Add('*.DBF');
   Zip;
   for j := 0 to Count-1 do    // Iterate
      DeleteFile(AdsConnectionExport.ConnectPath+'\'+Filename[j]);
  end;

 ShowMessage('Экспорт создан нормально'+#13+s);
 AsaStoredProcEndExport.ParamByName('@LocCode').Value:=DataModuleHM.LocCode;
 AsaStoredProcEndExport.ExecProc;
end;

procedure TImportExportModule.ExecuteImport;
var i,j:integer;
    ZipFile:string;
begin

  FilesScanner.FileMask:='*.zip';
  FilesScanner.ScanDir:=AdsConnectionImport.ConnectPath;
  FilesScanner.Scan;

  try
  DataModuleHM.AsaSessionHM.StartTransaction;
  for j := 0 to FilesScanner.FilesCount-1 do    // Iterate
  begin
   ZipFile:=TFileObject(FilesScanner.Files.Items[j]).FileName;

   AsaStoredProcLastExport.ParamByName('@LocCode').Value:=NumOffice(ZipFile);
   AsaStoredProcLastExport.ExecProc;

   if AsaStoredProcLastExport.ParamByName('@LastExportNum').Value+1<NumBatch(ZipFile) then
     raise Exception.Create('Это не тот импорт, очередной № '+IntToStr(AsaStoredProcLastExport.ParamByName('@LastExportNum').Value+1)+#13+'проверьте каталог с импортами');

   AsaStoredProcExistsExport.ParamByName('@LocCode').Value:=NumOffice(ZipFile);
   AsaStoredProcExistsExport.ParamByName('@ExportNum').Value:=NumBatch(ZipFile);
   AsaStoredProcExistsExport.ExecProc;

   if AsaStoredProcExistsExport.ParamByName('@Exp').Value>0 then
    begin
     ShowMessage('Такой импорт уже был' +#13+ZipFile);
     Continue;
    end;

   With  VCLUnZip do
    begin
     ZipName := AdsConnectionImport.ConnectPath+'\'+ZipFile;
     DestDir := AdsConnectionImport.ConnectPath;
     UnZip;
    end;

   AdsConnectionImport.IsConnected:=True;
   AsaStoredProcListExportTable.Open;
   MainForm.ProgressBar.Position:=0;
   MainForm.ProgressBar.Max:=AsaStoredProcListExportTable.RecordCount;
   while not AsaStoredProcListExportTable.EOF do
    begin
      if not FileExists(AdsConnectionImport.ConnectPath+'\'+AsaStoredProcListExportTableTableName.Value+'.DBF') then
        begin
          MainForm.ProgressBar.StepIt;
          AsaStoredProcListExportTable.Next;
          Continue;
        end;

      AdsTableImport.TableName:=AsaStoredProcListExportTableTableName.Value+'.DBF';
      AdsTableImport.Open;
      AsaStoredProcImport.StoredProcName:=AsaStoredProcListExportTableStoredProcImp.Value;

      AsaStoredProcImport.Prepare;
      while not AdsTableImport.Eof do
      begin
        for i := 0 to AsaStoredProcImport.ParamCount-1 do    // Iterate
          AsaStoredProcImport.Params[i].Clear;

        for i := 0 to AdsTableImport.FieldCount-1 do    // Iterate
          AsaStoredProcImport.Params[i].Value:=AdsTableImport.Fields[i].Value;

        AsaStoredProcImport.ExecProc;
        Application.ProcessMessages;
        AdsTableImport.Next;
      end;    // while
      AdsTableImport.Close;
      AsaStoredProcListExportTable.Next;
      MainForm.ProgressBar.StepIt;
    end;

   MainForm.ProgressBar.Position:=0;
   AsaStoredProcListExportTable.Close;
   AdsConnectionImport.IsConnected:=False;

   AsaStoredProcRefrDataLog.ParamByName('@LocCode').Value:=NumOffice(ZipFile);
   AsaStoredProcRefrDataLog.ParamByName('@ExportNum').Value:=NumBatch(ZipFile);
   AsaStoredProcRefrDataLog.ExecProc;

   With  VCLUnZip do
    begin
      ReadZip;
      for i := 0 to Count-1 do
        DeleteFile(AdsConnectionImport.ConnectPath+'\'+Filename[i]);
      FileUtil.MoveFile(AdsConnectionImport.ConnectPath+'\'+ZipFile,AdsConnectionImport.ConnectPath+'\Archive\'+ZipFile);
    end;
  end;    // for

  except
    on e: Exception do
     begin
       DataModuleHM.AsaSessionHM.Rollback;
       AsaStoredProcListExportTable.Close;
       AdsTableImport.Close;
       AdsConnectionImport.IsConnected:=False;
       ShowMessage(Format('%s'+#13+'импорт № %s таблица %s',[e.Message, ZipFile, AdsTableImport.TableName]));
       Exit;
     end;
  end;    // try/except

  DataModuleHM.AsaSessionHM.Commit;
  ShowMessage('Импорт нормально завершился');
end;

procedure TImportExportModule.ImportFarmWestOrder(Capt:string);
var InOutNum:integer;
begin
  Delete(Capt,Pos('&',Capt),1);

  if not OpenDialogFarmWest.Execute then
    Exit;

  if FileExists(AdsConnectionFarmWest.ConnectPath+'\Archive\'+ExtractFileName(OpenDialogFarmWest.FileName)) then
    begin
      ShowMessage('Такой файл уже был');
      Exit;
    end;

  AdsConnectionFarmWest.IsConnected:=True;
  with DataModuleHM do
  begin
  AsaSessionHM.StartTransaction;
  try
    FileUtil.CopyFile(OpenDialogFarmWest.FileName,AdsConnectionFarmWest.ConnectPath+'\TempDBF.dbf', nil);
    AdsQueryFWOrder.SQL.LoadFromFile(AdsConnectionFarmWest.ConnectPath+'\'+Capt+'.sql');
    AdsQueryFWOrder.Open;
  except
    on e: Exception do
     begin
      ShowMessage('Ошибка открытия файла '+ e.Message);
      Exit;
     end
  end;    // try/except

  AsaStoredProcRefrInOut_s.ParamByName('@LocCode').Value:=LocCode;
  AsaStoredProcRefrInOut_s.ParamByName('@Operator').Value:=Operator;
  AsaStoredProcRefrInOut_s.ParamByName('@ShipCode').Value:=1;
  AsaStoredProcRefrInOut_s.ParamByName('@Comment').Value:=ExtractFileName(OpenDialogFarmWest.FileName);
  AsaStoredProcRefrInOut_s.ExecProc;
  InOutNum:=AsaStoredProcRefrInOut_s.ParamByName('@InOutNum').Value;

  try
   while not AdsQueryFWOrder.EOF do
   begin
     AsaStoredProcEP.ParamByName('@ProdCode').Value:=AdsQueryFWOrder.FieldByName('ProdCode').Value;
     AsaStoredProcEP.ExecProc;
     if AsaStoredProcEP.ParamByName('@p').Value=0 then
     begin
       AsaStoredProcRefrProduct.ParamByName('@ProdCode').Value:=AdsQueryFWOrder.FieldByName('ProdCode').Value;
       AsaStoredProcRefrProduct.ParamByName('@ProdName').Value:=AdsQueryFWOrder.FieldByName('ProdName').Value;
       AsaStoredProcRefrProduct.ParamByName('@Box').Value:=AdsQueryFWOrder.FieldByName('Box').Value;
       AsaStoredProcRefrProduct.ParamByName('@Producer').Value:=AdsQueryFWOrder.FieldByName('Producer').Value;
       AsaStoredProcRefrProduct.ExecProc;
     end;
     if (AdsQueryFWOrder.FieldByName('ProdCode').Value<>'')and(AdsQueryFWOrder.FieldByName('Quantity').Value<>0) then
     begin
       AsaStoredProcRefrInOut_d.ParamByName('@InOutNum').Value:=InOutNum;
       AsaStoredProcRefrInOut_d.ParamByName('@ProdCode').Value:=AdsQueryFWOrder.FieldByName('ProdCode').Value;
       AsaStoredProcRefrInOut_d.ParamByName('@Quantity').Value:=AdsQueryFWOrder.FieldByName('Quantity').Value;
       AsaStoredProcRefrInOut_d.ParamByName('@Cost').Value:=AdsQueryFWOrder.FieldByName('Cost').Value;
       AsaStoredProcRefrInOut_d.ExecProc;
     end;

     AdsQueryFWOrder.Next;
     Application.ProcessMessages;
   end;    // while
  except
    on e: Exception do
     begin
       AsaSessionHM.Rollback;
       AdsQueryFWOrder.Close;
       AdsConnectionFarmWest.IsConnected:=False;
       ShowMessage('Ошибка импорта '+e.Message);
       Exit;
     end;
  end;    // try
  AsaSessionHM.Commit;
  AdsQueryFWOrder.Close;
  AdsConnectionFarmWest.IsConnected:=False;
  ShowMessage('Импорт закончен');
  DeleteFile(AdsConnectionFarmWest.ConnectPath+'\TempDBF.dbf');
  FileUtil.MoveFile(OpenDialogFarmWest.FileName,AdsConnectionFarmWest.ConnectPath+'\Archive\'+ExtractFileName(OpenDialogFarmWest.FileName));
  SetCurrentDir(ExtractFileDir(Application.ExeName));
 end;    // with
end;

procedure TImportExportModule.Pend(Capt:string);
begin
  Delete(Capt,Pos('&',Capt),1);

  if MessageDlg('Вы хотите ввести заводские платежи?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;
  AssignFile(f,ExtractFileDir(Application.ExeName)+'\Factory\pend.log');
  Rewrite(f);
  AdsConnectionFactory.IsConnected:=True;
  try
    AdsQueryListClients.SQL.LoadFromFile(AdsConnectionFactory.ConnectPath+'\'+Capt+'.sql');
    AdsQueryListClients.Open;
  except
    on e: Exception do
     begin
      ShowMessage('Ошибка открытия файла '+ e.Message);
      Exit;
     end
  end;    // try/except

  MainForm.ProgressBar.Position:=0;
  MainForm.ProgressBar.Max:=AdsQueryListClients.RecordCount;

  try
   while not AdsQueryListClients.EOF do
   begin
    try
      // statements to try
     AsaStoredProcSetPend.ParamByName('@LocCode').Value:=DataModuleHM.LocCode;
     AsaStoredProcSetPend.ParamByName('@Operator').Value:=DataModuleHM.Operator;

     if (copy(AdsQueryListClients.FieldByName('ClientNum').AsString,1,5)='00000')
     or (copy(AdsQueryListClients.FieldByName('ClientNum').AsString,1,5)='99999')
     or (copy(AdsQueryListClients.FieldByName('ClientNum').AsString,1,5)='     ')
     or (AdsQueryListClients.FieldByName('ClientNum').Value=Null)
      then
      begin
        AsaStoredProcSetPend.ParamByName('@ClientNum').Value:='_'+copy(AdsQueryListClients.FieldByName('ClientName').Value,1,9);
        writeln(f,AdsQueryListClients.FieldByName('ClientNum').Value, ' ',AdsQueryListClients.FieldByName('ClientName').Value);
      end
     else
     AsaStoredProcSetPend.ParamByName('@ClientNum').Value:=AdsQueryListClients.FieldByName('ClientNum').Value;
     AsaStoredProcSetPend.ParamByName('@ClientName').Value:=AdsQueryListClients.FieldByName('ClientName').Value;

     AsaStoredProcSetPend.ParamByName('@InsurNum').Value:=AdsQueryListClients.FieldByName('InsurNum').Value;
     AsaStoredProcSetPend.ParamByName('@FactoryNum').Value:=AdsQueryListClients.FieldByName('FactoryNum').Value;
     AsaStoredProcSetPend.ParamByName('@Fact').Value:=AdsQueryListClients.FieldByName('Fact').Value;
     AsaStoredProcSetPend.ParamByName('@TabN').Value:=AdsQueryListClients.FieldByName('TabN').Value;
     AsaStoredProcSetPend.ParamByName('@Finance').Value:=AdsQueryListClients.FieldByName('Finance').Value;

     if AdsQueryListClients.FieldByName('BeginDate').Value<>Null then
      AsaStoredProcSetPend.ParamByName('@BeginDate').Value:=AdsQueryListClients.FieldByName('BeginDate').Value
     else
      AsaStoredProcSetPend.ParamByName('@BeginDate').Clear;

     if AdsQueryListClients.FieldByName('TermDate').Value<>Null then
      AsaStoredProcSetPend.ParamByName('@TermDate').Value:=AdsQueryListClients.FieldByName('TermDate').Value
     else
      AsaStoredProcSetPend.ParamByName('@TermDate').Clear;

     AsaStoredProcSetPend.ParamByName('@Month').Value:=AdsQueryListClients.FieldByName('Month').Value;
     AsaStoredProcSetPend.ParamByName('@Year').Value:=AdsQueryListClients.FieldByName('Year').Value;

     if (AdsQueryListClients.FieldByName('NewClientNum').Value<>Null)and (Trim(AdsQueryListClients.FieldByName('NewClientNum').Value)<>'') then
      AsaStoredProcSetPend.ParamByName('@NewClientNum').Value:=AdsQueryListClients.FieldByName('NewClientNum').Value
     else
      AsaStoredProcSetPend.ParamByName('@NewClientNum').Value:='0';

     AsaStoredProcSetPend.ExecProc;
    except
      on e: Exception do
      writeln(f,e.message, ' ', AdsQueryListClients.FieldByName('ClientNum').AsString, ' ',AdsQueryListClients.FieldByName('ClientName').AsString);
    end;    // try/except
    AdsQueryListClients.Next;
    MainForm.ProgressBar.StepIt;
    Application.ProcessMessages;
   end;    // while
  finally // wrap up
     AdsQueryListClients.Close;
     CloseFile(f);
     ShowMessage('Ввод платежей закончен');
     MainForm.ProgressBar.Position:=0;
  end;    // try/finally
  AdsConnectionFactory.IsConnected:=False;
end;


end.
