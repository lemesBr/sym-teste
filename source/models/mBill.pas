unit mBill;

interface

uses mBase, FireDAC.Comp.Client, Data.DB, System.SysUtils, svcLibrary,
  System.Generics.Collections;

type
  TBill = class(TModel)
  private
    { private declarations }
    FSALE_ID: String;
    FPORTION: String;
    FDATE_DUE: TDate;
    FNET_TOTAL: Currency;

  protected
    { protected declarations }
    function store(): Boolean; override;
    function update(): Boolean; override;
    function validateFields(store: boolean): Boolean; override;
  public
    { public declarations }
    destructor Destroy; override;
    constructor Create();

    function save(): Boolean;
    procedure checkFieldTypes(query: TFDQuery);
    class function find(id: string): TBill;
    class function findBySaleId(saleId: string): TObjectList<TBill>;

    class procedure list(search: string; DataSet: TFDMemTable); overload;

    property SaleId: String read FSALE_ID write FSALE_ID;
    property Portion: String read FPORTION write FPORTION;
    property DateDue: TDate read FDATE_DUE write FDATE_DUE;
    property NetTotal: Currency read FNET_TOTAL write FNET_TOTAL;

  end;

implementation

{ TBill }

procedure TBill.checkFieldTypes(query: TFDQuery);
begin
  if query.Params.FindParam('ID') <> nil then
    query.Params.ParamByName('ID').DataType:= ftString;
  if query.Params.FindParam('SALE_ID') <> nil then
    query.Params.ParamByName('SALE_ID').DataType:= ftString;
  if query.Params.FindParam('PORTION') <> nil then
    query.Params.ParamByName('PORTION').DataType:= ftString;
  if query.Params.FindParam('DATE_DUE') <> nil then
    query.Params.ParamByName('DATE_DUE').DataType:= ftDate;
  if query.Params.FindParam('NET_TOTAL') <> nil then
    query.Params.ParamByName('NET_TOTAL').DataType:= ftCurrency;
  query.Prepare();
end;

constructor TBill.Create;
begin
  Self.Table:= 'BILLS';
end;

destructor TBill.Destroy;
begin
  inherited;
end;

class function TBill.find(id: string): TBill;
const
  FSql: string = 'SELECT * FROM BILLS WHERE (ID = :ID)';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('ID').AsString:= id;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TBill.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.SaleId:= FDQuery.FieldByName('SALE_ID').AsString;
        Result.Portion:= FDQuery.FieldByName('PORTION').AsString;
        Result.DateDue:= FDQuery.FieldByName('DATE_DUE').AsDateTime;
        Result.NetTotal:= FDQuery.FieldByName('NET_TOTAL').AsCurrency;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TBill.findBySaleId(saleId: string): TObjectList<TBill>;
const
  FSql: string =
  'SELECT ID FROM BILLS ' +
  'WHERE SALE_ID =:SALE_ID ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('SALE_ID').DataType:= ftFixedWideChar;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('SALE_ID').AsString:= saleId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TBill>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TBill.find(FDQuery.FieldByName('ID').AsString));
          FDQuery.Next;
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class procedure TBill.list(search: string; DataSet: TFDMemTable);
begin

end;

function TBill.save: Boolean;
begin
  Self.store;
end;

function TBill.store: Boolean;
var
  query: TFDQuery;
begin
  Result:= True;
  try
    Self.StartTransaction();
    query:= Self.createQuery;

    try
      query.SQL.Add(listFields(Self.Table, ['deleted_at'], false));
      checkFieldTypes(query);

      Self.Id:= Self.generateId;

      query.Params.ParamByName('ID').AsString:= Self.Id;
      query.Params.ParamByName('SALE_ID').AsString:= Self.SaleId;
      query.Params.ParamByName('PORTION').AsString:= Self.Portion;
      query.Params.ParamByName('DATE_DUE').AsDate:= Self.DateDue;
      query.Params.ParamByName('NET_TOTAL').AsCurrency:= Self.NetTotal;
      query.ExecSQL();

      Self.Commit();
    except on e: Exception do
      begin
        Self.Rollback();
        Result:= False;
        raise Exception.Create('Falha ao gravar dados de Recebimentos. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(query);
  end;
end;

function TBill.update: Boolean;
begin
  Result:= False;
end;

function TBill.validateFields(store: boolean): Boolean;
begin
  //
end;

end.
