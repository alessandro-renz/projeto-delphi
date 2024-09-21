unit cVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Param, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs, Vcl.Controls, Data.DB,
  Datasnap.DBClient;

Type TVenda = class
    private
      FVendaId: integer;
      FClienteId: integer;
      FDataVenda: TDateTime;
      FTotalVenda: double;
      conexao: TFDConnection;
      cdsItens: TClientDataSet;
      procedure InserirItems(vendaId: integer);

    public
      constructor Create(conexaoDB: TFDConnection; cds: TClientDataSet);
      destructor Destroy;
      function Selecionar(id: integer): boolean;
      function Inserir: integer;
      function Remover: boolean;
      function Atualizar: boolean;
      function getTotalVenda: double;
    published
      property VendaId: integer read FVendaId write FVendaId;
      property ClienteId: integer read FClienteId write FClienteId;
      property DataVenda: TDateTime read FDataVenda write FDataVenda;
      property TotalVenda: double read FTotalVenda write FTotalVenda;

end;

implementation

constructor TVenda.Create(conexaoDB: TFDConnection; cds: TClientDataSet);
begin
  conexao := conexaoDB;
  cdsItens := cds;
end;

function TVenda.getTotalVenda: double;
begin
  Result := 0;
  cdsItens.First;
  while not cdsItens.Eof do
  begin
    Result := Result + cdsItens.FieldByName('valorTotalProduto').AsFloat;
    cdsItens.Next;
  end;
end;

function TVenda.Atualizar: boolean;
begin

end;


function TVenda.Inserir: integer;
var
  query: TFDQuery;
  vendaId: integer;
begin
  Result := 0;
  if conexao.InTransaction then
     conexao.Commit;
  conexao.StartTransaction;
  query := TFDQuery.Create(nil);
  query.Connection := conexao;
  query.SQL.Clear;
  query.SQL.Add('INSERT INTO vendas (clienteid, datavenda, totalvenda)'+
              'VALUES(:clienteid, :datavenda, :totalvenda) RETURNING vendaid;');
  query.ParamByName('clienteid').AsInteger := FClienteId;
  query.ParamByName('datavenda').AsDateTime := FDataVenda;
  query.ParamByName('totalvenda').AsFloat := FTotalVenda;

  try
    query.Open;
    vendaId := query.FieldByName('vendaid').AsInteger;
    query.Close;
    cdsItens.First;
    while not cdsItens.Eof do
    begin
      InserirItems(vendaId);
      cdsItens.Next;
    end;

    conexao.Commit;
    Result := vendaId;
  except
    conexao.Rollback;
    Result := 0;
  end;

end;

procedure TVenda.InserirItems(vendaId: integer);
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := conexao;
  query.Sql.Clear;
  query.SQL.Add('INSERT INTO vendasItens (vendaid, produtoid, datavenda, valorUnitario, quantidade, totalProduto)'+
              'VALUES(:vendaid, :produtoid, :datavenda, :valorUnitario, :quantidade, :totalProduto);');
  query.ParamByName('vendaid').AsInteger := vendaId;
  query.ParamByName('produtoid').AsInteger := cdsItens.FieldByName('produtoid').AsInteger;
  query.ParamByName('datavenda').AsDateTime := FDataVenda;
  query.ParamByName('valorUnitario').AsFloat := cdsItens.FieldByName('valorUnitario').AsFloat;
  query.ParamByName('quantidade').AsFloat := cdsItens.FieldByName('quantidade').AsFloat;
  query.ParamByName('totalProduto').AsFloat := cdsItens.FieldByName('valorTotalProduto').AsFloat;

  try
    query.ExecSQL;
  finally
    FreeAndNil(query);
  end;
end;

function TVenda.Remover: boolean;
begin

end;

function TVenda.Selecionar(id: integer): boolean;
begin

end;

destructor TVenda.Destroy;
begin
  if Assigned(conexao) then
     FreeAndNil(conexao);
end;

end.
