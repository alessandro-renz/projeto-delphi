unit uCadEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, RxToolEdit, RxCurrEdit, cEstoque, uDtmConexao, uEnum;

type
  TfrmCadEstoque = class(TfrmTelaHeranca)
    qryListagemPRODUTOID: TIntegerField;
    qryListagemNOME: TStringField;
    qryListagemQUANTIDADE: TFMTBCDField;
    qryListagemULTIMA_ENTRADA: TSQLTimeStampField;
    Label1: TLabel;
    edtQuantidade: TCurrencyEdit;
    Label3: TLabel;
    edtQuantidadeMinima: TCurrencyEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtProduto: TLabeledEdit;
    qryListagemQUANTIDADE_MINIMA: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    oEstoque: TEstoque;

  public
    { Public declarations }
    function Gravar(estado: TEstadoCadastro): boolean; Override;
  end;

var
  frmCadEstoque: TfrmCadEstoque;

implementation

{$R *.dfm}


procedure TfrmCadEstoque.FormCreate(Sender: TObject);
begin
  inherited;
  oEstoque := TEstoque.create(dtmConexao.FDConnection);
  IndiceAtual := 'ULTIMA_ENTRADA';
end;


procedure TfrmCadEstoque.btnAlterarClick(Sender: TObject);
begin
  edtProduto.Text := qryListagem.FieldByName('NOME').AsString;
  edtQuantidadeMinima.Value := qryListagem.FieldByName('QUANTIDADE_MINIMA').AsFloat;
  inherited;
end;


function TfrmCadEstoque.Gravar(estado: TEstadoCadastro): boolean;
begin
  oEstoque.ProdutoId := qryListagem.FieldByName('PRODUTOID').AsInteger;
  oEstoque.Quantidade := edtQuantidade.Value;
  oEstoque.QuantidadeMinima := edtQuantidadeMinima.Value;
  oEstoque.UltimaEntrada := Now;
  if oEstoque.AddEntrada then
     ShowMessage('Quantidade adicionada no produto:'+#13+edtProduto.Text);

end;


procedure TfrmCadEstoque.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(oEstoque) then
     FreeAndNil(oEstoque);
end;

end.
