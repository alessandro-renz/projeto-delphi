unit uDtmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef;

type
  TdtmConexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ExecQuery(sql: string);
    function CreateTableCategorias: boolean;
    function CreateTableClientes: boolean;
    function CreateTableProdutos: boolean;
    function CreateTableVendas: boolean;
    function CreateTableVendasItens: boolean;
  end;

var
  dtmConexao: TdtmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdtmConexao.CreateTableCategorias: boolean;
begin
  ExecQuery('IF OBJECT_ID(''categorias'') is NULL'+
  'BEGIN'+
    'CREATE TABLE categorias('+
      'categoriaId int IDENTITY(1,1) NOT NULL,'+
      'descricao varchar(30) NULL,'+
      'PRIMARY KEY (categoriaId)'+
    ')'+
  'END');
end;

function TdtmConexao.CreateTableClientes: boolean;
begin
  ExecQuery('IF OBJECT_ID(''clientes'') is NULL'+
  'BEGIN'+
    'CREATE TABLE clientes('+
      'clienteId int IDENTITY(1,1) NOT NULL,'+
      'nome varchar(60) NOT NULL,'+
      'endereco varchar(100) NOT NULL,'+
      'cidade varchar(60) NOT NULL,'+
      'bairro varchar(60) NOT NULL,'+
      'estado char(2) NOT NULL,' +
      'cep varchar(8) NOT NULL,'+
      'telefone varchar(15),'+
      'email varchar(100),'+
      'dataNascimento date,'+
      'PRIMARY KEY(clienteId)'+
    ')'+ 
  'END');
end;

function TdtmConexao.CreateTableProdutos: boolean;
begin
  ExecQuery( 'IF OBJECT_ID(''produtos'') is NULL'+
  'BEGIN'+
    'CREATE TABLE produtos('+
      'produtoId int IDENTITY(1,1) NOT NULL,'+
      'categoriaId int NOT NULL,'+
      'nome varchar(100) NOT NULL,'+
      'descricao varchar(255),'+
      'valor money DEFAULT 0.000,'+
      'quantidade money DEFAULT 0.000,'+
      'PRIMARY KEY(produtoId),'+
      'CONSTRAINT FK_ProdutosCategorias'+
      'FOREIGN KEY (categoriaId) REFERENCES categorias(categoriaId)'+
    ')'+
  'END');
end;

function TdtmConexao.CreateTableVendas: boolean;
begin
  ExecQuery('IF OBJECT_ID(''vendas'') is NULL'+
  'BEGIN'+
    'CREATE TABLE vendas('+
      'vendaId int IDENTITY(1,1) NOT NULL,'+
      'clienteId INT,'+
      'dataVenda datetime DEFAULT getdate(),'+
      'totalVenda money DEFAULT 0.000,'+
      'PRIMARY KEY(vendaId),' +
      'CONSTRAINT FK_CLIENTES_VENDAS'+
      'FOREIGN KEY(clienteId) REFERENCES clientes(clienteId)'+
    ')'+
  'END');
end;

function TdtmConexao.CreateTableVendasItens: boolean;
begin
  ExecQuery('IF OBJECT_ID(''vendasItens'') is NULL'+
  'BEGIN'+
    'CREATE TABLE vendasItens('+
      'vendaId int NOT NULL,'+
      'produtoId int NOT NULL,'+
      'valorUnitario money DEFAULT 0.000,'+
      'quantidade money DEFAULT 0.000,' +
      'totalProduto money DEFAULT 0.000,'+
      'PRIMARY KEY(vendaId, produtoId),'+
      'CONSTRAINT FK_VENDA_ITENS'+
      'FOREIGN KEY (vendaId) REFERENCES vendas(vendaId)'+
    ')'+
  'END');
end;

procedure TdtmConexao.ExecQuery(sql: string);
var
  query: TFDquery;
begin
  FDPhysMSSQLDriverLink := TFDPhysMSSQLDriverLink.Create(nil);
  if FDConnection.InTransaction then
     FDConnection.Commit;

  query := TFDquery.Create(nil);
  query.Connection := FDConnection;
  query.Sql.Clear;
  query.SQL.Text := sql;
  try
    query.ExecSQL;
    FDConnection.Commit;     
  except on E: Exception do
  begin
    raise Exception.Create('Erro na execução da query');
    FDConnection.Rollback;    
  end
  end;

end;


end.
