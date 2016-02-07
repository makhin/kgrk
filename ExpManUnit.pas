unit ExpManUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls, StdCtrls, FilesScn, FlList, FileUtil;

type
  TExpManForm = class(TForm)
    PanelTop: TPanel;
    StringGridExports: TStringGrid;
    ButtonCopyToA: TButton;
    FilesScanner: TFilesScanner;
    procedure ButtonCopyToAClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExpManForm: TExpManForm;

implementation

{$R *.DFM}

procedure TExpManForm.ButtonCopyToAClick(Sender: TObject);
begin
 try
   // statements to try
   FileUtil.CopyFile(TFileObject(FilesScanner.Files.Items[StringGridExports.Row-1]).FullPath+TFileObject(FilesScanner.Files.Items[StringGridExports.Row-1]).FileName,'a:\'+TFileObject(FilesScanner.Files.Items[StringGridExports.Row-1]).FileName, nil);
 except
   on e: Exception do
     ShowMessage('Ошибка копирования "'+e.Message+'"');
 end;    // try/except
end;

procedure TExpManForm.FormShow(Sender: TObject);
var j:integer;
begin
  StringGridExports.Cells[0,0]:='Экспорт';
  StringGridExports.Cells[1,0]:='Дата';
  FilesScanner.ScanDir:=ExtractFileDir(Application.ExeName)+'\Export';
  FilesScanner.Scan;
  StringGridExports.RowCount:=FilesScanner.FilesCount+1;
  for j := 0 to FilesScanner.FilesCount-1 do    // Iterate
   begin
     StringGridExports.Cells[0,j+1]:=TFileObject(FilesScanner.Files.Items[j]).FileName;
     StringGridExports.Cells[1,j+1]:=DateToStr(FileDateToDateTime(TFileObject(FilesScanner.Files.Items[j]).FileTime));
   end;
end;
end.
