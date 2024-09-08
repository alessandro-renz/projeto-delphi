unit cCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Param, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

Type
  TCategoria = class

    private
      FCategoriaId: Integer;
      FDescricao: String;
      conexao: TFDConnection;
      function GetCategoriaId: integer;
      procedure SetCategoriaId(const Value: integer);
      function GetDescricao: String;
      procedure SetDescricao(const Value: String);
    public
      function Inserir: boolean;
      function Apagar(id: integer): boolean;
      function Atualizar: boolean;
      function Selecionar(id: integer): boolean;
      constructor Create(conexaoDB: TFDConnection);
    published
      property Codigo: Integer read GetCategoriaId write SetCategoriaId;
      property Descricao: String read GetDescricao write SetDescricao;
  end;

implementation

{ TCategoria }

constructor TCategoria.Create(conexaoDB: TFDConnection);
begin
  conexao := conexaoDB;
end;


function TCategoria.GetCategoriaId: integer;
begin
  Result := FCategoriaId;
end;

function TCategoria.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TCategoria.Inserir: boolean;
var
  query: TFDQuery;
  sqlText: String;
begin
  Result := True;
  try
    sqlText := 'INSERT INTO CATEGORIAS (DESCRICAO) VALUES(:descricao)';
    query := TFDQuery.Create(nil);
    query.Connection := conexao;
    query.SQL.Clear;
    query.SQL.Add(sqlText);
    query.ParamByName('descricao').Value := self.FDescricao;
    try
      query.ExecSQL;
    Except
      Result := False;
    end;

  finally
    if Assigned(query) then
      FreeAndNil(query);
  end;

end;

function TCategoria.Selecionar(id: integer): boolean;
var
  query: TFDQuery;
  sqlText: String;
begin
  Result := True;
  try
    sqlText := 'SELECT CATEGORIAID, DESCRICAO FROM CATEGORIAS WHERE CATEGORIAID=:categoriaId';
    query := TFDQuery.Create(nil);
    query.Connection := conexao;
    query.SQL.Clear;
    query.SQL.Add(sqlText);
    query.ParamByName('categoriaId').AsInteger := id;
    try
      query.Open;
      Self.FCategoriaId := query.FieldByName('CATEGORIAID').AsInteger;
      Self.FDescricao := query.FieldByName('DESCRICAO').AsString;
    Except
      Result := False;
    end;

  finally
    if Assigned(query) then
      FreeAndNil(query);
  end;

end;


function TCategoria.Apagar(id: integer): boolean;
var
  query: TFDQuery;
  sqlText: String;
begin
  Result := True;
  try
    sqlText := 'DELETE FROM CATEGORIAS WHERE CATEGORIAID=:categoriaId;';
    query := TFDQuery.Create(nil);
    query.Connection := conexao;
    query.SQL.Clear;
    query.SQL.Add(sqlText);
    query.ParamByName('categoriaId').AsInteger := id;
    try
      query.ExecSql;
    Except
      Result := False;
    end;

  finally
    if Assigned(query) then
      FreeAndNil(query);
  end;

end;


function TCategoria.Atualizar: boolean;
var
  query: TFDQuery;
  sqlText: String;
begin
    Result := True;
    try
    sqlText := 'UPDATE CATEGORIAS SET DESCRICAO=:descricao WHERE CATEGORIAID=:categoriaId;';
    query := TFDQuery.Create(nil);
    query.Connection := conexao;
    query.SQL.Clear;
    query.SQL.Add(sqlText);
    query.ParamByName('categoriaId').Value := self.FCategoriaId;
    query.ParamByName('descricao').Value := self.FDescricao;
    try
      query.ExecSQL;
    Except
      Result := False;
    end;
  finally
    if Assigned(query) then
      FreeAndNil(query);
  end;
end;

procedure TCategoria.SetCategoriaId(const Value: integer);
begin
  FCategoriaId := Value;
end;

procedure TCategoria.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
