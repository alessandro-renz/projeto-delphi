unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, RxToolEdit, RxCurrEdit, uEnum, cProduto, uDtmConexao, cEstoque,
  Datasnap.DBClient;

type
  TfrmCadProduto = class(TfrmTelaHeranca)
    edtNome: TLabeledEdit;
    edtCodigo: TLabeledEdit;
    edtValor: TCurrencyEdit;
    Label1: TLabel;
    lkpCategoria: TDBLookupComboBox;
    Label2: TLabel;
    qryCategoria: TFDQuery;
    dtsCategoria: TDataSource;
    qryCategoriaCATEGORIAID: TIntegerField;
    qryCategoriaDESCRICAO: TStringField;
    edtDescricao: TMemo;
    Label4: TLabel;
    qryListagemPRODUTOID: TIntegerField;
    qryListagemNOME: TStringField;
    qryListagemDESCRICAO: TStringField;
    qryListagemVALOR: TFMTBCDField;
    qryListagemCATEGORIA: TStringField;
    tabEstoque: TTabSheet;
    Label3: TLabel;
    Label6: TLabel;
    edtQuantidade: TCurrencyEdit;
    Label7: TLabel;
    edtQuantidadeMinima: TCurrencyEdit;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    oProduto: TProduto;
    oEstoque: TEstoque;
  public
    { Public declarations }
    function Gravar(estado: TEstadoCadastro): boolean;override;
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

{$R *.dfm}

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  oProduto := TProduto.Create(dtmConexao.FDConnection);
  oEstoque := TEstoque.Create(dtmConexao.FDConnection);
  IndiceAtual := 'NOME';
end;


procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  edtCodigo.Text := qrylistagem.FieldByName('PRODUTOID').AsString;
end;


function TfrmCadProduto.Gravar(estado: TEstadoCadastro): boolean;
var
  msgConfirmation: TModalResult;
  textMsg: string;
begin
  if edtCodigo.Text <> EmptyStr then
     oProduto.Codigo := strToInt(edtCodigo.Text);

  oProduto.Nome := edtNome.Text;
  oProduto.Descricao := edtDescricao.Text;
  oProduto.Valor := strToFloat(edtValor.Text);
  oProduto.CategoriaId := strToInt(lkpCategoria.KeyValue);
  if (estado = ecInserir) AND (oProduto.Inserir) then
  begin
    oEstoque.ProdutoID := oProduto.LastId;
    oEstoque.Quantidade := edtQuantidade.Value;
    oEstoque.QuantidadeMinima := edtQuantidadeMinima.Value;
    oEstoque.Inserir;
    ShowMessage('Produto adicionado com sucesso!');
  end
  else if (estado = ecAlterar) AND (oProduto.Atualizar) then
  begin
    ShowMessage('Produto atualizado com sucesso!');
  end
  else
    ShowMessage('Ocorreu um erro pra salvar/atualizar produto!');;
end;


procedure TfrmCadProduto.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(oProduto) then
     FreeAndNil(oProduto);
end;

end.
