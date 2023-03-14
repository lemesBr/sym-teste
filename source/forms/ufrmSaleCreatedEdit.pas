unit ufrmSaleCreatedEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBaseCreatedEdit, Vcl.ExtCtrls,
  Vcl.StdCtrls, mSale, Vcl.Mask, svcLibrary, svcAuth, CustomEditHelper,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  System.StrUtils, System.DateUtils, mBill;

type
  TfrmSaleCreatedEdit = class(TfrmBaseCreatedEdit)
    Panel1: TPanel;
    Panel2: TPanel;
    lbe_Description: TLabeledEdit;
    cbx_Payment: TComboBox;
    Label7: TLabel;
    lbe_SaleValue: TLabeledEdit;
    pnl_BtnCalc: TPanel;
    ds_Bills: TDataSource;
    fdmt_Bills: TFDMemTable;
    DBGrid: TDBGrid;
    fdmt_BillsPORTION: TStringField;
    fdmt_BillsDATE_DUE: TDateField;
    fdmt_BillsNET_TOTAL: TCurrencyField;
    fdmt_BillsID: TStringField;
    fdmt_BillsSALE_ID: TStringField;
    procedure pnl_BtnCancellClick(Sender: TObject);
    procedure pnl_BtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnl_BtnCalcClick(Sender: TObject);
    procedure cbx_PaymentChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    Sale: TSale;
    function validateEdits: Boolean;
    procedure ObjToEdt;
    procedure EdtToObj;
    procedure save();
  public
    { Public declarations }
  end;

var
  frmSaleCreatedEdit: TfrmSaleCreatedEdit;

implementation

{$R *.dfm}

{ TfrmSaleCreatedEdit }

procedure TfrmSaleCreatedEdit.cbx_PaymentChange(Sender: TObject);
begin
  pnl_BtnCalcClick(Sender);
end;

procedure TfrmSaleCreatedEdit.EdtToObj;
begin
  Sale.Description:= lbe_Description.Text;
  Sale.NetTotal:= TLibrary.StringToExtended(lbe_SaleValue.Text);
  Sale.FormPayment:= cbx_Payment.ItemIndex;

  Sale.Bills.Clear;
  with fdmt_Bills do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      Sale.Bills.Add(TBill.Create);
      Sale.Bills.Last.Portion:= fdmt_BillsPORTION.AsString;
      Sale.Bills.Last.DateDue:= fdmt_BillsDATE_DUE.AsDateTime;
      Sale.Bills.Last.NetTotal:= fdmt_BillsNET_TOTAL.AsCurrency;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TfrmSaleCreatedEdit.FormCreate(Sender: TObject);
begin
  inherited;
  TCustomEdit(lbe_SaleValue).EditFloat();
  if TAuth.SaleId = EmptyStr then Sale:= TSale.Create
  else Sale:= TSale.find(TAuth.SaleId);
  ObjToEdt;
end;

procedure TfrmSaleCreatedEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Sale);
end;

procedure TfrmSaleCreatedEdit.FormShow(Sender: TObject);
begin
  inherited;
  ArredondarComponente(pnl_BtnCalc, 5);
end;

procedure TfrmSaleCreatedEdit.ObjToEdt;
begin
  if (Sale.Id = EmptyStr) then
  begin
    lbl_TitleForm.Caption:= 'Cadastro de Nova Venda';
    Exit();
  end;
  lbl_TitleForm.Caption:= 'Alterar dados de Venda';

  lbe_Description.Text:= Sale.Description;
  lbe_SaleValue.Text:= TLibrary.ExtendedToString(Sale.NetTotal);
  cbx_payment.ItemIndex:= Sale.FormPayment;
  TSale.listBills(Sale.Id, fdmt_Bills)
end;

procedure TfrmSaleCreatedEdit.pnl_BtnCalcClick(Sender: TObject);
var
  I: Integer;
begin
  case cbx_Payment.ItemIndex of
    0: begin
      fdmt_Bills.Open();
      fdmt_Bills.DisableControls;
      fdmt_Bills.EmptyDataSet;

      fdmt_Bills.Append;
      fdmt_Bills.FieldByName('PORTION').AsString:= 'À Vista';
      fdmt_Bills.FieldByName('DATE_DUE').AsDateTime:= Now;
      fdmt_Bills.FieldByName('NET_TOTAL').AsCurrency:= TLibrary.StringToExtended(lbe_SaleValue.Text);
      fdmt_Bills.Post;


      fdmt_Bills.EnableControls;
    end;
    1:begin
      fdmt_Bills.Open();
      fdmt_Bills.DisableControls;
      fdmt_Bills.EmptyDataSet;

      for I := 1 to 3 do
      begin
        fdmt_Bills.Append;
        fdmt_Bills.FieldByName('PORTION').AsString:= IntToStr(I) + '/3';
        fdmt_Bills.FieldByName('DATE_DUE').AsDateTime:= IncMonth(Now, I -1);
        if I = 1 then
          fdmt_Bills.FieldByName('NET_TOTAL').AsCurrency:= TLibrary.StringToExtended(lbe_SaleValue.Text) * 50 / 100
        else
          fdmt_Bills.FieldByName('NET_TOTAL').AsCurrency:= (TLibrary.StringToExtended(lbe_SaleValue.Text) * 50 / 100) / 2;
        fdmt_Bills.Post;
      end;

      fdmt_Bills.EnableControls;
    end;
    2:begin
      fdmt_Bills.Open();
      fdmt_Bills.DisableControls;
      fdmt_Bills.EmptyDataSet;

      for I := 1 to 2 do
      begin
        fdmt_Bills.Append;
        fdmt_Bills.FieldByName('PORTION').AsString:= IntToStr(I) + '/2';
        fdmt_Bills.FieldByName('DATE_DUE').AsDateTime:= IncMonth(Now, I);
        fdmt_Bills.FieldByName('NET_TOTAL').AsCurrency:= TLibrary.StringToExtended(lbe_SaleValue.Text)  / 2;
        fdmt_Bills.Post;
      end;

      fdmt_Bills.EnableControls;
    end;
    3:begin
      fdmt_Bills.Open();
      fdmt_Bills.DisableControls;
      fdmt_Bills.EmptyDataSet;
      fdmt_Bills.Append;
      fdmt_Bills.FieldByName('PORTION').AsString:= '1/1';
      fdmt_Bills.FieldByName('DATE_DUE').AsDateTime:= IncDay(Now, 15);
      fdmt_Bills.FieldByName('NET_TOTAL').AsCurrency:= TLibrary.StringToExtended(lbe_SaleValue.Text);
      fdmt_Bills.Post;
      fdmt_Bills.EnableControls;
    end;
  end;
end;

procedure TfrmSaleCreatedEdit.pnl_BtnCancellClick(Sender: TObject);
begin
  inherited;
  TAuth.SaleId:= EmptyStr;
end;

procedure TfrmSaleCreatedEdit.pnl_BtnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TfrmSaleCreatedEdit.save;
begin
  EdtToObj;
  if validateEdits and Sale.save then
    Close;
end;

function TfrmSaleCreatedEdit.validateEdits: Boolean;
var
  v_required: Integer;
begin
  v_required:= 0;
  if (Trim(lbe_Description.Text) = '') then
  begin
    setEditRequired(lbe_Description);
    Inc(v_required);
  end;
  Result:= (v_required = 0);
  if (not Result) then  TLibrary.showMessage('Atenção', 'É necessário preencher os campos', 0);
end;

end.
