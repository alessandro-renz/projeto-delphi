unit cDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Param, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, uDtmConexao, uEnum;

Type TDB = class
     private
        query: TFDQuery;
     public
        constructor Create;
        destructor Destroy;
        procedure addSql(sql: string);
        procedure AddParam(paramName: string; value: Variant);
        function ExecSql(sql: string): boolean;
     published
end;

implementation

{ TDB }

constructor TDB.Create;
begin
  query := TFDQuery.Create(nil);
  query.Connection := dtmConexao.FDConnection;
end;


procedure TDB.addSql(sql: string);
begin
    query.SQL.Clear;
    query.SQL.Text := sql;
end;


procedure TDB.AddParam(paramName: string; value: Variant);
begin
    if VarIsStr(value) then
       query.ParamByName(paramName).AsString := value
    else if(VarIsNumeric(value)) then
       query.ParamByName(paramName).AsInteger := value
    else if(VarIsFloat(value)) then
      query.ParamByName(paramName).AsFloat := value;
end;


function TDB.ExecSql(sql: string): boolean;
begin
    dtmConexao.FDConnection.StartTransaction;
    try
      query.ExecSQL;
      dtmConexao.FDConnection.Commit;
    except
      dtmConexao.FDConnection.Rollback;
    end;
end;


destructor TDB.Destroy;
begin
    if Assigned(query) then
      FreeAndNil(query);
end;

end.
