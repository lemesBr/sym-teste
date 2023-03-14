unit ufrmSaleList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBaseList, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Vcl.ExtCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, mSale, svcAuth;

type
  TfrmSaleList = class(TfrmBaseList)
    fdmt_BaseID: TStringField;
    fdmt_BaseCODE: TIntegerField;
    fdmt_BaseDESCRIPTION: TStringField;
    fdmt_BaseNET_TOTAL: TCurrencyField;
    fdmt_BaseFORM_PAYMENT: TStringField;
    fdmt_Bills: TFDMemTable;
    fdmt_BillsPORTION: TStringField;
    fdmt_BillsDATE_DUE: TDateField;
    fdmt_BillsNET_TOTAL: TCurrencyField;
    ds_Bills: TDataSource;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    fdmt_BillsID: TStringField;
    fdmt_BillsSALE_ID: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure pnl_BtnaDDClick(Sender: TObject);
    procedure pnl_BtnEditClick(Sender: TObject);
    procedure ds_BaseDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    procedure list(search: string); override;
  public
    { Public declarations }
  end;

var
  frmSaleList: TfrmSaleList;

implementation

{$R *.dfm}

uses ufrmSaleCreatedEdit;

{ TfrmSaleList }

procedure TfrmSaleList.ds_BaseDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if fdmt_Base.RecordCount >= 1 then
    TSale.listBills(fdmt_BaseID.AsString, fdmt_Bills);
end;

procedure TfrmSaleList.FormCreate(Sender: TObject);
begin
  inherited;
  createdFormClass:= TfrmSaleCreatedEdit;
  list('');
end;

procedure TfrmSaleList.list(search: string);
begin
  TSale.list(search, fdmt_Base);
end;

procedure TfrmSaleList.pnl_BtnaDDClick(Sender: TObject);
begin
  TAuth.SaleId:= EmptyStr;
  inherited;
end;

procedure TfrmSaleList.pnl_BtnEditClick(Sender: TObject);
begin
  TAuth.SaleId:= fdmt_BaseID.AsString;
  inherited;
end;

end.
