unit InsNewOrderUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask, DBCtrls, Grids, DBGridEh, Buttons, db, RXMemDS;

type
  TInsOrderForm = class(TForm)
    PanelTop: TPanel;
    PanelBottom: TPanel;
    DBGridEhOrder_d: TDBGridEh;
    BitBtnSave: TBitBtn;
    BitBtnCancel: TBitBtn;
    DBGridEhCostStock: TDBGridEh;
    MemoComment: TMemo;
    BitBtnSavePrint: TBitBtn;
    Label1: TLabel;
    BitBtnPaid: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure DBGridEhOrder_dKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoCommentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure BitBtnSavePrintClick(Sender: TObject);
    procedure BitBtnPaidClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OrderNum:integer;
    InsurCaseNum:Integer;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure save(Paid:byte);
  end;

var
  InsOrderForm: TInsOrderForm;

implementation
uses DataUnit, ReportUnit, ListStockFromNameUnit;

{$R *.DFM}

procedure TInsOrderForm.CMDialogKey(var Message: TCMDialogKey);
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

procedure TInsOrderForm.FormActivate(Sender: TObject);
begin
    if OrderNum=0 then
     begin
      MemoComment.Text:=TimeToStr(Now)+' ';
      MemoComment.SetFocus;
     end
    else
     begin
      DataModuleHM.AsaStoredProcShowOrder.Close;
      DataModuleHM.AsaStoredProcShowOrder.ParamByName('@OrderNum').Value:=OrderNum;
      DataModuleHM.AsaStoredProcShowOrder.Open;
      DataModuleHM.AsaStoredProcShowOrder_d.Close;
      DataModuleHM.AsaStoredProcShowOrder_d.ParamByName('@OrderNum').Value:=OrderNum;
      DataModuleHM.AsaStoredProcShowOrder_d.Open;
      DataModuleHM.RxMemoryDataOrder_d.EmptyTable;
      MemoComment.Text:=DataModuleHM.AsaStoredProcShowOrderComment.Text;
      DataModuleHM.RxMemoryDataOrder_d.LoadFromDataSet(DataModuleHM.AsaStoredProcShowOrder_d,0,lmAppend);
      DataModuleHM.RxMemoryDataOrder_d.Open;
      DataModuleHM.RxMemoryDataOrder_d.Edit;
      DBGridEhOrder_d.SetFocus;
      DBGridEhOrder_d.SelectedIndex:=0;
     end

end;

procedure TInsOrderForm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TInsOrderForm.BitBtnSaveClick(Sender: TObject);
begin
   save(1);  // Если включим провести, то изменить на 1
   Close;
end;

procedure TInsOrderForm.DBGridEhOrder_dKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key=VK_F1) then
  begin
   ListStockFromNameForm.ShowModal;
   exit;
  end;

 if (Key=VK_RETURN) then
  with DataModuleHM do
  begin
    case DBGridEhOrder_d.SelectedIndex of    //
      0: begin
           DBGridEhOrder_d.SelectedIndex:=3;
           if DataModuleHM.RxMemoryDataOrder_dProdCode.Value<>'' then
            begin
              AsaStoredProcShowProduct.Close;
              AsaStoredProcShowProduct.ParamByName('@ProdCode').Value:=RxMemoryDataOrder_dProdCode.Value;
              AsaStoredProcShowProduct.Open;
//              AsaStoredProcListCostStock.Close;
//              AsaStoredProcListCostStock.ParamByName('@ProdCode').Value:=RxMemoryDataOrder_dProdCode.Value;
//              AsaStoredProcListCostStock.Open;
              RxMemoryDataOrder_dCost.Value:=AsaStoredProcListCostStockCost.Value;
              RxMemoryDataOrder_dProdName.Value:=AsaStoredProcShowProductProdName.Value;
              if RxMemoryDataOrder_dCost.Value=0 then
                DBGridEhOrder_d.SelectedIndex := 2
            end
         end;
      2: begin
           DBGridEhOrder_d.SelectedIndex:=3;
         end;
      3: begin
          if ((RxMemoryDataOrder_d.State=dsEdit)or (RxMemoryDataOrder_d.State=dsInsert)) then
             RxMemoryDataOrder_d.Post;

          if (DataModuleHM.RxMemoryDataOrder_dProdCode.Value<>'')and(DataModuleHM.RxMemoryDataOrder_dQuantity.Value<>0) then
           begin

             DataModuleHM.AsaStoredProcExistProdCode.Close;
             DataModuleHM.AsaStoredProcExistProdCode.ParamByName('@ProdCode').Value:=DataModuleHM.RxMemoryDataOrder_dProdCode.Value;
             DataModuleHM.AsaStoredProcExistProdCode.ParamByName('@Cost').Value:=DataModuleHM.RxMemoryDataOrder_dCost.Value;
             DataModuleHM.AsaStoredProcExistProdCode.Open;

             if (DataModuleHM.AsaStoredProcExistProdCode.Eof) then
             begin
                if MessageDlg('Продукта с этим кодом и ценой не существует. Продолжаем?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
                begin
                  DBGridEhOrder_d.SelectedIndex:=0;
                  RxMemoryDataOrder_d.Edit;
                  DataModuleHM.AsaStoredProcExistProdCode.Close;
                  Exit;
                end;
             end
             else
             begin
              if DataModuleHM.AsaStoredProcExistProdCodeCurr_Stock.Value<DataModuleHM.RxMemoryDataOrder_dQuantity.Value then
                if MessageDlg('Кол-во больше, чем есть на стоке ('+ DataModuleHM.AsaStoredProcExistProdCodeCurr_Stock.AsString +'). Продолжаем?', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
                begin
                  DBGridEhOrder_d.SelectedIndex:=3;
                  RxMemoryDataOrder_d.Edit;
                  DataModuleHM.AsaStoredProcExistProdCode.Close;
                  Exit;
                end;
             end;
             DataModuleHM.AsaStoredProcExistProdCode.Close;
           end;

           RxMemoryDataOrder_d.Append;
           DBGridEhOrder_d.SelectedIndex:=0;
         end;
    end;    // case
  end;    // with
 if (Key=VK_ESCAPE) then
 BitBtnSave.SetFocus;
end;


procedure TInsOrderForm.MemoCommentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=VK_RETURN then
 with DataModuleHM do
 begin
   RxMemoryDataOrder_d.Open;
   RxMemoryDataOrder_d.Append;
   DBGridEhOrder_d.SetFocus;
   DBGridEhOrder_d.SelectedIndex:=0;
 end;    // with
end;

procedure TInsOrderForm.FormDeactivate(Sender: TObject);
begin
  with DataModuleHM do
  begin
    AsaStoredProcListCostStock.Close;
    AsaStoredProcShowProduct.Close;
    RxMemoryDataOrder_d.Open;
    RxMemoryDataOrder_d.First;
    while not RxMemoryDataOrder_d.Eof do
     RxMemoryDataOrder_d.Delete;
    RxMemoryDataOrder_d.Close;
  end;    // with
end;

procedure TInsOrderForm.Save(Paid:byte);
var i:Integer;
begin
   with DataModuleHM do
   begin
    try
      // statements to try
     RxMemoryDataOrder_d.DisableControls;
     AsaSessionHM.StartTransaction;
     AsaStoredProcRefrOrder_s.ParamByName('@LocCode').Value:=LocCode;
     AsaStoredProcRefrOrder_s.ParamByName('@InsurCaseNum').Value:=InsurCaseNum;
     AsaStoredProcRefrOrder_s.ParamByName('@OrderNum').Value:=OrderNum;
     AsaStoredProcRefrOrder_s.ParamByName('@Operator').Value:=Operator;
     AsaStoredProcRefrOrder_s.ParamByName('@Comment').Value:=MemoComment.Text;
     AsaStoredProcRefrOrder_s.ParamByName('@paid').Value:=Paid;
     AsaStoredProcRefrOrder_s.ExecProc;
     OrderNum:=AsaStoredProcRefrOrder_s.ParamByName('@OrderNum').Value;

     if RxMemoryDataOrder_d.Active=False then
      raise Exception.Create('Пустая накладная');

     RxMemoryDataOrder_d.First;
     i:=0;
     while not RxMemoryDataOrder_d.EOF do
     begin
       if (RxMemoryDataOrder_dProdCode.Value<>'')and(RxMemoryDataOrder_dQuantity.Value<>0) then
         begin
 
           AsaStoredProcEP.ParamByName('@ProdCode').Value:=RxMemoryDataOrder_dProdCode.Value;;
           AsaStoredProcEP.ExecProc;
           if AsaStoredProcEP.ParamByName('@p').Value=0 then
           begin
             AsaStoredProcRefrProduct.ParamByName('@ProdCode').Value:=RxMemoryDataOrder_dProdCode.Value;
             AsaStoredProcRefrProduct.ParamByName('@ProdName').Value:=RxMemoryDataOrder_dProdName.Value;
             AsaStoredProcRefrProduct.ParamByName('@Box').Value:=0;
             AsaStoredProcRefrProduct.ParamByName('@Producer').Value:='Не определен';
             AsaStoredProcRefrProduct.ExecProc;
           end;

	   AsaStoredProcRefrOrder_d.ParamByName('@OrderNum').Value:=OrderNum;
           AsaStoredProcRefrOrder_d.ParamByName('@ProdCode').Value:=RxMemoryDataOrder_dProdCode.Value;
           AsaStoredProcRefrOrder_d.ParamByName('@Quantity').Value:=RxMemoryDataOrder_dQuantity.Value;
           {
           if Pos('ЧЕК', UpperCase(MemoComment.Text))=0 then
                   AsaStoredProcRefrOrder_d.ParamByName('@Cost').Value:=Round(95*RxMemoryDataOrder_dCost.Value)/100 // сохраняем сумму - 5%
           else
                   AsaStoredProcRefrOrder_d.ParamByName('@Cost').Value:=Round(100*RxMemoryDataOrder_dCost.Value)/100; // сохраняем сумму если чек
           }
           AsaStoredProcRefrOrder_d.ParamByName('@Cost').Value:=RxMemoryDataOrder_dCost.Value;
           AsaStoredProcRefrOrder_d.ExecProc;
           Inc(i);
         end;
       RxMemoryDataOrder_d.Next;
     end;    // while

     if i=0 then
       raise Exception.Create('Пустая накладная');

    AsaSessionHM.Commit;
    RxMemoryDataOrder_d.EnableControls;
    except
      on e: Exception do
      begin
        ShowMessage('Ошибка '+e.Message);
        AsaSessionHM.Rollback;
        RxMemoryDataOrder_d.EnableControls;
      end;
    end;    // try/except
   end;    // with
end;

procedure TInsOrderForm.BitBtnSavePrintClick(Sender: TObject);
begin
 save(1);
 ReportModuleHM.PrintOrder(OrderNum);
 Close;
end;

procedure TInsOrderForm.BitBtnPaidClick(Sender: TObject);
begin
  if MessageDlg('Вы уверены, что хотите закрыть эту накладную?',
    mtConfirmation, [mbYes,mbNo], 0) = mrNo then Exit;

  save(1);
  Close;
end;

end.
