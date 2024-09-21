unit cEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Param, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs, Vcl.Controls, uDtmVenda;

Type TEstoque = class
     public
        constructor Create(connection: TFDConnection);
        destructor Destroy;
        function Inserir: boolean;
        function AddEntrada: boolean;
        function AddSaida(vendaId:integer): boolean;
     private
        FAlmoxarifadoID: integer;
        FProdutoID: integer;
        FQuantidade: double;
        FQuantidadeMinima: double;
        FUltimaEntrada: TDateTime;
        FUltimaSaida: TDateTime;
        qry: TFDQuery;
        conexao: TFDConnection;
        sql: string;
     published
        property AlmoxarifadoID: integer read FAlmoxarifadoID write FAlmoxarifadoID;
        property ProdutoID: integer read FProdutoID write FProdutoID;
        property Quantidade: double read FQuantidade write FQuantidade;
        property QuantidadeMinima: double read FQuantidadeMinima write FQuantidadeMinima;
        property UltimaEntrada: TDateTime read FUltimaEntrada write FUltimaEntrada;
        property UltimaSaida: TDateTime read FUltimaSaida write FUltimaSaida;
end;

implementation

{ Estoque }
constructor TEstoque.Create(connection: TFDConnection);
begin
  conexao := connection;
  qry := TFDQuery.Create(nil);
  qry.Connection := connection;
  qry.SQL.Clear;
end;


function TEstoque.Inserir: boolean;
begin
  conexao.StartTransaction;
  sql := 'INSERT INTO ESTOQUE (PRODUTOID, QUANTIDADE, QUANTIDADE_MINIMA) '+
         ' VALUES(:PRODUTOID, :QUANTIDADE, :QUANTIDADE_MINIMA)';
  qry.SQL.Add(sql);
  qry.ParamByName('PRODUTOID').AsInteger := FProdutoID;
  qry.ParamByName('QUANTIDADE').AsFloat := FQuantidade;
  qry.ParamByName('QUANTIDADE_MINIMA').AsFloat := FQuantidadeMinima;

  try
    qry.ExecSQL;
    conexao.Commit;
    Result := True;
  except
    conexao.RollBack;
    Result := False;
  end;
end;


function TEstoque.AddEntrada: boolean;
begin
  conexao.StartTransaction;
  qry.SQL.Clear;
  sql := 'UPDATE ESTOQUE SET QUANTIDADE=QUANTIDADE + :QUANTIDADE, QUANTIDADE_MINIMA=:QUANTIDADE_MINIMA, ULTIMA_ENTRADA=:ULTIMA_ENTRADA '+
         ' WHERE PRODUTOID = :PRODUTOID';
  qry.SQL.Add(sql);
  qry.ParamByName('PRODUTOID').AsInteger := FProdutoID;
  qry.ParamByName('QUANTIDADE').AsFloat := FQuantidade;
  qry.ParamByName('QUANTIDADE_MINIMA').AsFloat := FQuantidadeMinima;
  qry.ParamByName('ULTIMA_ENTRADA').AsDateTime := FUltimaEntrada;

  try
    qry.ExecSQL;
    conexao.Commit;
    Result := True;
  except
    conexao.RollBack;
    Result := False;
  end;
end;


function TEstoque.AddSaida(vendaId: integer): boolean;
begin
  conexao.StartTransaction;
  qry.SQL.Clear;
  sql := 'UPDATE ESTOQUE SET QUANTIDADE=QUANTIDADE - :QUANTIDADE, '+
         ' ULTIMA_SAIDA=:ULTIMA_SAIDA WHERE PRODUTOID = :PRODUTOID';
  qry.SQL.Add(sql);

  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do
  begin
      qry.ParamByName('PRODUTOID').AsInteger := dtmVenda.cdsItensVenda.FieldByName('PRODUTOID').AsInteger;
      qry.ParamByName('QUANTIDADE').AsFloat := dtmVenda.cdsItensVenda.FieldByName('QUANTIDADE').AsFloat;
      qry.ParamByName('ULTIMA_SAIDA').AsDateTime := Now;

      try
        qry.ExecSQL;
        dtmVenda.cdsItensVenda.Next;
      except
        Result := False;
        conexao.Rollback;
        Exit;
      end;

  end;
  conexao.Commit;
  Result := True;
end;


destructor TEstoque.Destroy;
begin
  if conexao.InTransaction then
     conexao.Rollback;
  FreeAndNil(qry);
end;

end.
