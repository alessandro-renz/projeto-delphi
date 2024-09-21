unit cProduto;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Param, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs, Vcl.Controls;

Type
  TProduto = class
    private
        FProdutoId: integer;
        FNome: string;
        FDescricao: string;
        FValor: double;
        FCategoriaId: integer;
        Query: TFDQuery;
        Conexao: TFDConnection;
        FLastId: integer;
    public
        constructor Create(conexaoDB: TFDConnection);
        destructor Destroy;
        function Selecionar(id: integer): boolean;
        function Inserir: boolean;
        function Remover: boolean;
        function Atualizar: boolean;
    published
      property Codigo:integer read FProdutoId write FProdutoId;
      property Nome:string read FNome write FNome;
      property Descricao:string read FDescricao write FDescricao;
      property Valor:double read FValor write FValor;
      property CategoriaId:integer read FCategoriaId write FCategoriaId;
      property LastId: integer read FLastId;
  end;

implementation
  constructor TProduto.Create(conexaoDB: TFDConnection);
  begin
    Query := TFDQuery.Create(nil);
    Query.Connection := conexaoDB;
    Query.SQL.Clear;

  end;


  function TProduto.Atualizar: boolean;
  begin

  end;

  function TProduto.Inserir: boolean;
  begin
    Query.SQL.Add('insert into produtos (NOME, DESCRICAO, VALOR, CATEGORIAID) '+
                  ' values(:nome, :descricao, :valor, :categoriaid) RETURNING PRODUTOID;');
    Query.ParamByName('nome').AsString := FNome;
    Query.ParamByName('descricao').AsString := FDescricao;
    Query.ParamByName('valor').AsFloat := FValor;
    Query.ParamByName('categoriaid').AsInteger := FCategoriaId;

    try
      Query.Open;
      FLastId := Query.FieldByName('PRODUTOID').AsInteger;
      Result := True;
    except
      FLastId := 0;
      Result := False;
      Query.Close;
      FreeAndNil(Query);
      Exit;
    end;

  end;

  function TProduto.Remover: boolean;
  begin

  end;

  function TProduto.Selecionar(id: integer): boolean;
  begin

  end;

  destructor TProduto.Destroy;
  begin
    if Assigned(Query) then
       FreeAndNil(Query);
  end;
end.
