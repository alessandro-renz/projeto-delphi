unit uCadVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, uDtmConexao, uDtmVenda, RxToolEdit, RxCurrEdit, uEnum, cVenda, cEstoque;

type
  TfrmCadVenda = class(TfrmTelaHeranca)
    qryListagemVENDAID: TIntegerField;
    qryListagemDATAVENDA: TSQLTimeStampField;
    qryListagemTOTALVENDA: TFMTBCDField;
    qryListagemNOME: TStringField;
    edtNumeroVenda: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    Label1: TLabel;
    edtData: TDateEdit;
    Label2: TLabel;
    lkpProduto: TDBLookupComboBox;
    Label3: TLabel;
    edtUnitario: TCurrencyEdit;
    Label4: TLabel;
    edtQuantidade: TCurrencyEdit;
    Label5: TLabel;
    edtValorTotalProduto: TCurrencyEdit;
    lblValorTotalProduto: TLabel;
    btnAddProduto: TBitBtn;
    btnRemoveProduto: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    Label7: TLabel;
    edtTotalValorVenda: TCurrencyEdit;
    gridItensVenda: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtUnitarioChange(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    function Gravar(estado: TEstadoCadastro): boolean; override;
    procedure FormDestroy(Sender: TObject);
    procedure btnAddProd(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
    oVenda: TVenda;
    oEstoque: TEstoque;
    procedure atualizarValorTotalVenda;
    function ValorTotalProduto: double;

  public
    { Public declarations }
  end;

var
  frmCadVenda: TfrmCadVenda;

implementation

{$R *.dfm}
procedure TfrmCadVenda.FormCreate(Sender: TObject);
begin
  inherited;
  oVenda := TVenda.Create(dtmConexao.FDConnection, dtmVenda.cdsItensVenda);
  oEstoque := TEstoque.Create(dtmConexao.FDConnection);
  IndiceAtual := 'NOME';
end;


procedure TfrmCadVenda.btnAddProd(Sender: TObject);
begin
  if dtmVenda.cdsItensVenda.Locate('produtoid', lkpProduto.KeyValue, []) then
  begin
    ShowMessage('Esse item ja foi adicionado!');
    Abort;
  end;

  dtmVenda.cdsItensVenda.Append;
  dtmVenda.cdsItensVenda.FieldByName('produtoid').AsInteger := dtmVenda.qryProduto.FieldByName('produtoid').AsInteger;
  dtmVenda.cdsItensVenda.FieldByName('nomeProduto').AsString := dtmVenda.qryProduto.FieldByName('nome').AsString;
  dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat := StrToFloat(edtQuantidade.Text);
  dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat := StrToFloat(edtUnitario.Text);
  dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat := ValorTotalProduto;
  dtmVenda.cdsItensVenda.Post;
  atualizarValorTotalVenda;

  lkpProduto.keyValue := Null;
  edtUnitario.Value := 0;
  edtQuantidade.Value := 0;
  edtValorTotalProduto.Value := 0;
  lkpProduto.SetFocus;
end;

procedure TfrmCadVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  lkpCliente.keyValue := Null;
  edtData.Text := EmptyStr;
  lkpProduto.keyValue := Null;
  edtUnitario.Value := 0;
  edtQuantidade.Value := 0;
  edtValorTotalProduto.Value := 0;
  edtTotalValorVenda.Value := 0;
  dtmVenda.cdsItensVenda.EmptyDataSet;
end;

procedure TfrmCadVenda.atualizarValorTotalVenda;
begin
  oVenda.TotalVenda := oVenda.getTotalVenda;
  edtTotalValorVenda.Value := oVenda.getTotalVenda;
end;

procedure TfrmCadVenda.edtQuantidadeChange(Sender: TObject);
begin
  edtValorTotalProduto.Value := ValorTotalProduto;
end;

procedure TfrmCadVenda.edtUnitarioChange(Sender: TObject);
begin
  edtValorTotalProduto.Value := ValorTotalProduto;
end;


function TfrmCadVenda.Gravar(estado: TEstadoCadastro): boolean;
var
  lastIdVenda: integer;
begin
  oVenda.ClienteId := lkpCliente.KeyValue;
  oVenda.DataVenda := StrToDate(edtData.Text);
  oVenda.TotalVenda := edtTotalValorVenda.Value;
  lastIdVenda := 0;
  if estado = ecInserir then
    lastIdVenda := oVenda.Inserir;

  if estado = ecAlterar then
    oVenda.Atualizar;

  if (lastIdVenda > 0) AND (oEstoque.AddSaida(lastIdVenda)) then
  begin
      ShowMessage('Venda Adicionada!');
      lkpCliente.keyValue := Null;
      edtData.Text := EmptyStr;
      lkpProduto.keyValue := Null;
      edtUnitario.Value := 0;
      edtQuantidade.Value := 0;
      edtValorTotalProduto.Value := 0;
      edtTotalValorVenda.Value := 0;
      dtmVenda.cdsItensVenda.EmptyDataSet;
  end;


  Result := True;
end;


procedure TfrmCadVenda.lkpProdutoExit(Sender: TObject);
begin
    edtUnitario.Value := dtmVenda.qryProduto.fieldByName('valor').AsFloat;
    edtQuantidade.Value := 1;
    edtValorTotalProduto.Value := ValorTotalProduto;
end;

function TfrmCadVenda.ValorTotalProduto: double;
begin
  Result := edtUnitario.Value * edtQuantidade.Value;
end;

procedure TfrmCadVenda.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(oVenda) then
     FreeAndNil(oVenda);
end;

end.
