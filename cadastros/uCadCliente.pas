unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, RxToolEdit, Rest.Client, REST.Types,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, cCliente, uDtmConexao, uEnum;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCep: TMaskEdit;
    Label1: TLabel;
    edtEstado: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtTelefone: TMaskEdit;
    label2: TLabel;
    edtEmail: TLabeledEdit;
    edtNascimento: TDateEdit;
    Label3: TLabel;
    qryListagemCLIENTEID: TIntegerField;
    qryListagemNOME: TStringField;
    qryListagemCIDADE: TStringField;
    qryListagemESTADO: TStringField;
    qryListagemTELEFONE: TStringField;
    qryListagemDATANASCIMENTO: TDateField;
    procedure edtCepChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
      restClient: TRESTClient;
      restRequest: TRESTRequest;
      oCliente: TCliente;
    function Gravar(estado: TEstadoCadastro): boolean; override;
  public
    { Public declarations }
  end;
  const BASE_URL = 'https://viacep.com.br/ws';

var
  frmCadCliente: TfrmCadCliente;


implementation

{$R *.dfm}


function TfrmCadCliente.Gravar(estado: TEstadoCadastro): boolean;
begin
  if edtCodigo.Text <> EmptyStr then
     oCliente.Codigo := StrToInt(edtCodigo.Text);

  oCliente.Nome := Trim(edtNome.Text);
  oCliente.Cep := Trim(edtCep.Text);
  oCliente.Cidade := Trim(edtCidade.Text);
  oCliente.Endereco := Trim(edtEndereco.Text);
  oCliente.Estado := Trim(edtEstado.Text);
  oCliente.Bairro := Trim(edtBairro.Text);
  oCliente.Telefone := Trim(edtTelefone.Text);
  oCliente.Email := Trim(edtEmail.Text);
  oCliente.DataNascimento := Trim(edtNascimento.Text);

  if (estado = ecInserir) AND (oCliente.Inserir) then
  begin
    ShowMessage('Cliente adicionado com sucesso!');
    Result := True;
    Abort;
  end;

  if oCliente.Atualizar then
     ShowMessage('Cliente editado com sucesso!');
  Result := False;
end;

procedure TfrmCadCliente.edtCepChange(Sender: TObject);
var
  cep: string;
  response: TJSONValue;
begin
  cep := Trim(edtCep.Text);
  if cep.Length <> 8 then
     Abort;

  try
      restClient := TRESTClient.Create(BASE_URL + '/' + cep + '/json');
      restRequest := TRESTRequest.Create(restClient);
      restRequest.Execute;
      response := restRequest.Response.JSONValue;
      edtCidade.Text := response.GetValue<string>('localidade');
      edtEstado.Text := response.GetValue<string>('uf');

  finally
    if Assigned(restRequest) then
       FreeAndNil(restRequest);

    if Assigned(restClient) then
       FreeAndNil(restClient);
  end;



end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  oCliente := TCliente.Create(dtmConexao.FDConnection);
  IndiceAtual := 'NOME';
end;

procedure TfrmCadCliente.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(oCliente) then
     FreeAndNil(oCliente);
end;

end.
