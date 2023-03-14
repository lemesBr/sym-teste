unit mBase;

interface

uses
  mConnection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.DateUtils,
  System.SysUtils, system.StrUtils, System.Classes,
  System.Generics.Collections, svcLibrary;

type
  TModel = class
  private
    FID: String;
  protected
    Table: string;

    function generateId(): string;
    function getNextNumber(Column: String): Integer;
    function store(): Boolean; virtual; abstract;
    function update(): Boolean; virtual; abstract;
    function validateFields(store: boolean): Boolean; virtual; abstract;
    function unicValueInTable(field, fieldValue: String): Boolean;
    function save(): Boolean;

    class function createQuery(): TFDQuery;
    class function listFields(tableName: String; noGetFields: array of string; update: Boolean): string;

    class procedure StartTransaction;
    class procedure Commit;
    class procedure Rollback;
  public

    property Id: String  read FID write FID;
  end;

implementation

{ TModel }

class procedure TModel.Commit;
begin
  TConnection.GetInstance.Commit;
end;

class function TModel.createQuery: TFDQuery;
begin
  Result:= TFDQuery.Create(nil);
  Result.Connection:= TConnection.GetInstance();
end;

function TModel.generateId: string;
var
  vKey: string;
begin
  Sleep(2);
  vKey:=
    FormatDateTime('yyyymmddhhmmss', Now) + '-' +
    Self.Table + '-' +
    MilliSecondOfTheYear(Now).ToString() + '-' +
    TLibrary.SerialDrive('C');
  Result:= UpperCase(TLibrary.MD5String(vKey));
end;

function TModel.getNextNumber(Column: String): Integer;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FSql:= 'SELECT MAX('+ Column +') AS R_NUMBER  FROM ' + Table +
    ' WHERE ('+ Column +' <= 99999999)';
    FDQuery:= createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Prepare();
      FDQuery.Open();
      Result:= (FDQuery.FieldByName('R_NUMBER').AsInteger + 1);
    except
      Result:= 0;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

class function TModel.listFields(tableName: String;
  noGetFields: array of string; update: Boolean): string;
var
  query: TFDQuery;
  I: Integer;
  listFields: TStringList;
  resultSql: string;
begin
  try
    //SELECT * FROM sys.columns WHERE object_id = object_id('nome_tabela')
    query:= Self.createQuery;
    query.SQL.Add('select * from sys.columns WHERE object_id = object_id(' + QuotedStr(tableName) + ')');
    query.Open();

    listFields:= TStringList.Create;
    while not query.Eof do
    begin
      if not MatchStr(query.FieldByName('name').AsString, noGetFields) then
        listFields.Add(query.FieldByName('name').AsString);
      query.Next;
    end;

    if update then
    begin
      resultSql:= 'UPDATE ' + tableName + ' SET';
      for I := 0 to Pred(listFields.Count) do
        resultSql:= resultSql + ' ' + listFields[I] + ' = :' + listFields[I] + IfThen(I = listFields.Count - 1, '' , ', ');;

      resultSql:= resultSql + ' WHERE (ID = :ID);';
    end
    else
    begin
      resultSql:= 'INSERT INTO ' + tableName + ' (';
      for I := 0 to Pred(listFields.Count) do
        resultSql:= resultSql + listFields[I] + IfThen(I = listFields.Count - 1, ')' , ', ');

      resultSql:= resultSql + ' VALUES (';
      for I := 0 to Pred(listFields.Count) do
        resultSql:= resultSql + ':' + listFields[I] + IfThen(I = listFields.Count - 1, ')' , ', ');
    end;

  finally
    FreeAndNil(query);
    FreeAndNil(listFields);
    Result:= resultSql;
  end;
end;

class procedure TModel.Rollback;
begin
  TConnection.GetInstance.Rollback;
end;

function TModel.save: Boolean;
begin
  if ((self.FID = EmptyStr)
    and validateFields(True)) then
    Result:= Self.store
  else
  begin
    if (self.FID <> EmptyStr) and validateFields(False) then
    Result:= Self.update;
  end;
end;

class procedure TModel.StartTransaction;
begin
  TConnection.GetInstance.StartTransaction;
end;

function TModel.unicValueInTable(field, fieldValue: String): Boolean;
var
  FSql: string;
  FDQuery: TFDQuery;
begin
  try
    FSql:= 'SELECT * FROM ' + Table + ' WHERE ('+ field +' = :FIELD) AND (ID <> :ID)';
    FDQuery:= createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('FIELD').DataType:= ftString;
      FDQuery.Params.ParamByName('ID').DataType:= ftString;
      FDQuery.Prepare();
      FDQuery.Params.ParamByName('ID').AsString:= Self.Id;
      FDQuery.Open();
      Result:= (FDQuery.RecordCount = 0);
    except
      Result:= False;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.
