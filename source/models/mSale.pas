unit mSale;

interface

uses mBase, FireDAC.Comp.Client, Data.DB, System.SysUtils, svcLibrary,
  System.Generics.Collections, mBill;

type
  TSale = class(TModel)
  private
    { private declarations }
    FCODE: Integer;
    FDESCRIPTION: String;
    FNET_TOTAL: Currency;
    FFORM_PAYMENT: Integer;

    FBILLS: TObjectList<TBill>;

    function getBills: TObjectList<TBill>;
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
    class function find(id: string): TSale;

    class function list(search: string): TObjectList<TSale>; overload;
    class procedure list(search: string; DataSet: TFDMemTable); overload;

    class procedure listBills(id: string; DataSet: TFDMemTable);

    class function getFormPaymentString(formPayment: Integer): String;

    property Code: Integer read FCODE write FCODE;
    property Description: String read FDESCRIPTION write FDESCRIPTION;
    property NetTotal: Currency read FNET_TOTAL write FNET_TOTAL;
    property FormPayment: Integer read FFORM_PAYMENT write FFORM_PAYMENT;

    property Bills: TObjectList<TBill> read getBills;
  end;

implementation

{ TBill }


{ TSale }

procedure TSale.checkFieldTypes(query: TFDQuery);
begin
  if query.Params.FindParam('ID') <> nil then
    query.Params.ParamByName('ID').DataType:= ftString;
  if query.Params.FindParam('CODE') <> nil then
    query.Params.ParamByName('CODE').DataType:= ftInteger;
  if query.Params.FindParam('DESCRIPTION') <> nil then
    query.Params.ParamByName('DESCRIPTION').DataType:= ftString;
  if query.Params.FindParam('NET_TOTAL') <> nil then
    query.Params.ParamByName('NET_TOTAL').DataType:= ftCurrency;
  if query.Params.FindParam('FORM_PAYMENT') <> nil then
    query.Params.ParamByName('FORM_PAYMENT').DataType:= ftInteger;
  query.Prepare();
end;

constructor TSale.Create;
begin
  Self.Table:= 'SALES';
end;

destructor TSale.Destroy;
begin
  if Assigned(Self.FBILLS) then FreeAndNil(Self.FBILLS);
  inherited;
end;

class function TSale.find(id: string): TSale;
const
  FSql: string = 'SELECT * FROM SALES WHERE (ID = :ID)';
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
        Result:= TSale.Create;
        Result.Id:= FDQuery.FieldByName('ID').AsString;
        Result.Code:= FDQuery.FieldByName('CODE').AsInteger;
        Result.Description:= FDQuery.FieldByName('DESCRIPTION').AsString;
        Result.NetTotal:= FDQuery.FieldByName('NET_TOTAL').AsCurrency;
        Result.FormPayment:= FDQuery.FieldByName('FORM_PAYMENT').AsInteger;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

function TSale.getBills: TObjectList<TBill>;
begin
  if not Assigned(FBILLS) and (Self.Id <> EmptyStr) then
    Self.FBILLS:= TBill.findBySaleId(Self.Id);
  if not Assigned(FBILLS) then
    Self.FBILLS:= TObjectList<TBill>.Create;
  Result:= Self.FBILLS;
end;

class function TSale.getFormPaymentString(formPayment: Integer): String;
begin
  case formPayment of
    0: Result:= 'À Vista';
    1: Result:= '50% de Entrada + Restante em 30/60';
    2: Result:= '30/60 Sem Entrada';
    3: Result:= '15 dias';
  end;
end;

class function TSale.list(search: string): TObjectList<TSale>;
const
  FSql: string =
  'SELECT * FROM SALES S ' +
  'WHERE S.DESCRIPTION LIKE :SEARCH ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('SEARCH').DataType:= ftWideString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('SEARCH').AsString:= '%' + search + '%';
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TSale>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TSale.find(FDQuery.FieldByName('ID').AsString));
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

class procedure TSale.list(search: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TSale>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TSale.list(search);
  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('CODE').AsInteger:= vList.Items[I].Code;
      DataSet.FieldByName('DESCRIPTION').AsString:= vList.Items[I].Description;
      DataSet.FieldByName('NET_TOTAL').AsCurrency:= vList.Items[I].NetTotal;
      DataSet.FieldByName('FORM_PAYMENT').AsString:= getFormPaymentString(vList.Items[I].FormPayment);
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

class procedure TSale.listBills(id: string; DataSet: TFDMemTable);
var
  vList: TObjectList<TBill>;
  I: Integer;
begin
  DataSet.Open();
  DataSet.DisableControls;
  DataSet.EmptyDataSet;
  vList:= TBill.findBySaleId(id);

  if Assigned(vList) then
  begin
    for I := 0 to Pred(vList.Count) do
    begin
      DataSet.Append;
      DataSet.FieldByName('ID').AsString:= vList.Items[I].Id;
      DataSet.FieldByName('SALE_ID').AsString:= vList.Items[I].SaleId;
      DataSet.FieldByName('PORTION').AsString:= vList.Items[I].Portion;
      DataSet.FieldByName('DATE_DUE').AsDateTime:= vList.Items[I].DateDue;
      DataSet.FieldByName('NET_TOTAL').AsCurrency:= vList.Items[I].NetTotal;
      DataSet.Post;
    end;
    FreeAndNil(vList);
  end;
  DataSet.First;
  DataSet.EnableControls;
end;

function TSale.save: Boolean;
begin
  Result:= inherited;
end;

function TSale.store: Boolean;
var
  query: TFDQuery;
  I: Integer;
begin
  Result:= True;
  try
    Self.StartTransaction();
    query:= Self.createQuery;

    try
      query.SQL.Add(listFields(Self.Table, ['deleted_at'], false));
      checkFieldTypes(query);

      Self.Id:= Self.generateId;
      Self.Code:= Self.getNextNumber('CODE');

      query.Params.ParamByName('ID').AsString:= Self.Id;
      query.Params.ParamByName('CODE').AsInteger:= Self.Code;
      query.Params.ParamByName('DESCRIPTION').AsString:= Self.Description;
      query.Params.ParamByName('NET_TOTAL').AsCurrency:= Self.NetTotal;
      query.Params.ParamByName('FORM_PAYMENT').AsInteger:= Self.FormPayment;
      query.ExecSQL();

      for I:= 0 to Pred(Self.Bills.Count) do
      begin
        Self.Bills.Items[I].SaleId:= Self.Id;
        Self.Bills.Items[I].save();
      end;

      Self.Commit();
    except on e: Exception do
      begin
        Self.Rollback();
        Result:= False;
        raise Exception.Create('Falha ao gravar dados de Venda. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(query);
  end;
end;

function TSale.update: Boolean;
var
  query: TFDQuery;
  I: Integer;
begin
  Result:= True;
  try
    Self.StartTransaction();
    query:= Self.createQuery;

    try
      query.SQL.Add(listFields(Self.Table, ['deleted_at'], true));
      checkFieldTypes(query);

      query.Params.ParamByName('ID').AsString:= Self.Id;
      query.Params.ParamByName('DESCRIPTION').AsString:= Self.Description;
      query.Params.ParamByName('NET_TOTAL').AsCurrency:= Self.NetTotal;
      query.Params.ParamByName('FORM_PAYMENT').AsInteger:= Self.FormPayment;
      query.ExecSQL();

      query.Close();
      query.SQL.Clear();
      query.SQL.Add('DELETE FROM BILLS WHERE (SALE_ID = :SALE_ID)');
      query.Params.ParamByName('SALE_ID').DataType:= ftString;
      query.Prepare();
      query.Params.ParamByName('SALE_ID').AsString:=  Self.Id;
      query.ExecSQL();

      for I:= 0 to Pred(Self.Bills.Count) do
      begin
        Self.Bills.Items[I].SaleId:= Self.Id;
        Self.Bills.Items[I].save();
      end;

      Self.Commit();
    except on e: Exception do
      begin
        Self.Rollback();
        Result:= False;
        raise Exception.Create('Falha ao gravar dados da Venda. Erro: ' + e.Message);
      end;
    end;
  finally
    FreeAndNil(query);
  end;
end;

function TSale.validateFields(store: boolean): Boolean;
var
  vMensagem: string;
begin
  Result:= True;
  try
    if Self.Description = EmptyStr then
    begin
      vMensagem:= 'É necessário informar uma descrição!';
      Exit();
    end;
  finally
    if (vMensagem <> '') then
    begin
      TLibrary.showMessage('Atenção!', PWideChar(vMensagem), 0);
      Result:= False;
    end;
  end;
end;

end.
