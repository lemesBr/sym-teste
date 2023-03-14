unit mConnection;

interface

uses
  System.Classes, System.SysUtils, Vcl.Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.MSSQL, svcLibrary;

type
  TConnection = class(TFDConnection)
  strict private
    class var FInstance: TConnection;
    class procedure AutoConfig(Connection: TFDConnection);
  private
    class procedure ReleaseInstance();
  public
    class function GetInstance(): TConnection;
  end;

implementation

{ TConexao }

class procedure TConnection.AutoConfig(Connection: TFDConnection);
begin
  try
    Connection.Params.LoadFromFile(ExtractFilePath(Application.ExeName) + 'db.ini');
    Connection.Connected:= True;
  except
    TLibrary.showMessage('Atenção!','Banco de dados não conectado.', 0);
    FreeAndNil(Self.FInstance);
  end;
end;

class function TConnection.GetInstance: TConnection;
begin
  if not Assigned(Self.FInstance) then
  begin
    Self.FInstance:= TConnection.Create(nil);
    Self.AutoConfig(Self.FInstance);
  end;
  Result:= Self.FInstance;
end;

class procedure TConnection.ReleaseInstance;
begin
  if Assigned(Self.FInstance) then
    Self.FInstance.Free;
end;

initialization

finalization
  TConnection.ReleaseInstance();

end.
