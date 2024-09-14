unit cCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Param, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs, Vcl.Controls;

Type TCliente = class
    private
        FClienteId: integer;
        FNome: string;
        FEndereco: string;
        FCidade: string;
        FBairro: string;
        FEstado: string;
        FCep: string;
        FTelefone: string;
        FEmail: string;
        FDataNascimento: string;
        Query: TFDQuery;
        Conexao: TFDConnection;
    public
        constructor Create(conexaoDB: TFDConnection);
        destructor Destroy;
        function Selecionar(id: integer): boolean;
        function Inserir: boolean;
        function Remover: boolean;
        function Atualizar: boolean;
    published
      property Codigo:integer read FClienteId write FClienteId;
      property Nome:string read FNome write FNome;
      property Endereco:string read FEndereco write FEndereco;
      property Cidade:string read FCidade write FCidade;
      property Bairro:string read FBairro write FBairro;
      property Estado:string read FEstado write FEstado;
      property Cep:string read FCep write FCep;
      property Telefone:string read FTelefone write FTelefone;
      property Email:string read FEmail write FEmail;
      property DataNascimento:string read FDataNascimento write FDataNascimento;
end;

implementation

{ TCliente }

constructor TCliente.Create(conexaoDB: TFDConnection);
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := conexaoDB;
  Query.SQL.Clear;

end;


function TCliente.Atualizar: boolean;
begin

end;

function TCliente.Inserir: boolean;
begin
  Query.SQL.Add('insert into clientes (NOME, ENDERECO, CIDADE, BAIRRO, ESTADO, CEP, '+
                'TELEFONE, EMAIL, DATANASCIMENTO) values(:nome, :endereco, :cidade,'+
                ':bairro, :estado, :cep, :telefone, :email, :datanascimento)');
  Query.ParamByName('nome').AsString := FNome;
  Query.ParamByName('endereco').AsString := FEndereco;
  Query.ParamByName('cidade').AsString := FCidade;
  Query.ParamByName('bairro').AsString := FBairro;
  Query.ParamByName('estado').AsString := FEstado;
  Query.ParamByName('cep').AsString := FCep;
  Query.ParamByName('telefone').AsString := FTelefone;
  Query.ParamByName('email').AsString := FEmail;
  Query.ParamByName('datanascimento').AsDate := StrToDate(FDataNascimento);

  try
    Query.ExecSQL;
  except
    Result := false;
    Exit;
  end;
  Result := True;
end;

function TCliente.Remover: boolean;
begin

end;

function TCliente.Selecionar(id: integer): boolean;
begin

end;

destructor TCliente.Destroy;
begin
  if Assigned(Query) then
     FreeAndNil(Query);
end;

end.
