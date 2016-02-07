unit InsNewInOutUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, DBCtrls, Grids, DBGridEh, Buttons, db;

type
  TInsInOutForm = class(TForm)
    PanelTop: TPanel;
    PanelBottom: TPanel;
    DBGridEhInOut_d: TDBGridEh;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    MemoComment: TMemo;
    BitBtnPrint: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure DBGridEhInOut_dKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoCommentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure BitBtnPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    InOutNum:integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure save;
  end;

var
  InsInOutForm: TInsInOutForm;

implementation
uses DataUnit, ReportUnit;

{$R *.DFM}

procedure TInsInOutForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TInsInOutForm.FormActivate(Sender: TObject);
begin
    MemoComment.Text:=TimeToStr(Now)+' ';
    MemoComment.SetFocus;
end;

procedure TInsInOutForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TInsInOutForm.BitBtnSaveClick(Sender: TObject);
begin
   save;
   Close;
end;

procedure TInsInOutForm.DBGridEhInOut_dKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key=VK_RETURN) then
  with DataModuleHM do
  begin
    case DBGridEhInOut_d.SelectedIndex of    //
      0: begin
           DBGridEhInOut_d.SelectedIndex:=2;
           AsaStoredProcShowProduct.Close;
           AsaStoredProcShowProduct.ParamByName('@ProdCode').Value:=RxMemoryDataInOut_dProdCode.Value;
           AsaStoredProcShowProduct.Open;
           if AsaStoredProcShowProduct.Eof then
              RxMemoryDataInOut_dProdName.Value:='Введи название'
           else
            begin
              RxMemoryDataInOut_dProdName.Value:=AsaStoredProcShowProductProdName.Value;
              DBGridEhInOut_d.SelectedIndex:=3;
            end
         end;
      1: begin
           DBGridEhInOut_d.SelectedIndex:=3;
         end;
      2: begin
           DBGridEhInOut_d.SelectedIndex:=4;
         end;
      3: begin
           RxMemoryDataInOut_d.Post;
           RxMemoryDataInOut_d.Append;
           DBGridEhInOut_d.SelectedIndex:=0;
         end;
    end;    // case
  end;    // with
 if (Key=VK_ESCAPE) then
 BitBtnSave.SetFocus;
end;


procedure TInsInOutForm.MemoCommentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=VK_RETURN then
 with DataModuleHM do
 begin
   RxMemoryDataInOut_d.Open;
   RxMemoryDataInOut_d.Append;
   DBGridEhInOut_d.SetFocus;
   DBGridEhInOut_d.SelectedIndex:=0;
 end;    // with

end;

procedure TInsInOutForm.FormDeactivate(Sender: TObject);
begin
  with DataModuleHM do
  begin
    if RxMemoryDataInOut_d.Active=True then
      begin
       RxMemoryDataInOut_d.First;
       while not RxMemoryDataInOut_d.Eof do
        RxMemoryDataInOut_d.Delete;
       RxMemoryDataInOut_d.Close;
      end;
  end;    // with
end;

procedure TInsInOutForm.BitBtnPrintClick(Sender: TObject);
begin
  save;
  ReportModuleHM.PrintinOut(InOutNum);
  Close;
end;

procedure TInsInOutForm.save;
begin
   with DataModuleHM do
   begin
   try
     // statements to try
     AsaSessionHM.StartTransaction;
     AsaStoredProcRefrInOut_s.ParamByName('@LocCode').Value:=LocCode;
     AsaStoredProcRefrInOut_s.ParamByName('@ShipCode').Value:=1;
     AsaStoredProcRefrInOut_s.ParamByName('@Operator').Value:=Operator;
     AsaStoredProcRefrInOut_s.ParamByName('@Comment').Value:=MemoComment.Text;
     AsaStoredProcRefrInOut_s.ExecProc;
     InOutNum:=AsaStoredProcRefrInOut_s.ParamByName('@InOutNum').Value;

     if RxMemoryDataInOut_d.Active=False then
      raise Exception.Create('Пустая накладная');

     RxMemoryDataInOut_d.First;
     while not RxMemoryDataInOut_d.EOF do
     begin
       if (RxMemoryDataInOut_dProdCode.Value<>'')and(RxMemoryDataInOut_dQuantity.Value<>0) then
         begin

           AsaStoredProcEP.ParamByName('@ProdCode').Value:=RxMemoryDataInOut_dProdCode.Value;;
           AsaStoredProcEP.ExecProc;
           if AsaStoredProcEP.ParamByName('@p').Value=0 then
           begin
             AsaStoredProcRefrProduct.ParamByName('@ProdCode').Value:=RxMemoryDataInOut_dProdCode.Value;
             AsaStoredProcRefrProduct.ParamByName('@ProdName').Value:=RxMemoryDataInOut_dProdName.Value;
             AsaStoredProcRefrProduct.ParamByName('@Box').Value:=0;
             AsaStoredProcRefrProduct.ParamByName('@Producer').Value:='Не определен';
             AsaStoredProcRefrProduct.ExecProc;
           end;

           AsaStoredProcRefrInOut_d.ParamByName('@InOutNum').Value:=InOutNum;
           AsaStoredProcRefrInOut_d.ParamByName('@ProdCode').Value:=RxMemoryDataInOut_dProdCode.Value;
           AsaStoredProcRefrInOut_d.ParamByName('@Quantity').Value:=RxMemoryDataInOut_dQuantity.Value;
           AsaStoredProcRefrInOut_d.ParamByName('@Cost').Value:=RxMemoryDataInOut_dCost.Value;
           AsaStoredProcRefrInOut_d.ExecProc;
         end;
       RxMemoryDataInOut_d.Next;
     end;    // while
     AsaSessionHM.Commit;
   except
     on e: Exception do
     begin
       ShowMessage('Ошибка '+e.Message);
       AsaSessionHM.Rollback;
     end;
   end;    // try/except
   end;    // with
end;

end.
