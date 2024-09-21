unit uDtmVenda;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  Datasnap.DBClient, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDtmConexao, MidasLib;

type
  TdtmVenda = class(TDataModule)
    qryCliente: TFDQuery;
    qryProduto: TFDQuery;
    cdsItensVenda: TClientDataSet;
    dsCliente: TDataSource;
    dsProduto: TDataSource;
    dsItensVenda: TDataSource;
    cdsItensVendaprodutoId: TIntegerField;
    cdsItensVendavalorUnitario: TFloatField;
    cdsItensVendavalorTotalProduto: TFloatField;
    cdsItensVendaquantidade: TFloatField;
    qryClienteCLIENTEID: TIntegerField;
    qryClienteNOME: TStringField;
    qryProdutoPRODUTOID: TIntegerField;
    qryProdutoNOME: TStringField;
    qryProdutoVALOR: TFMTBCDField;
    cdsItensVendanomeProduto: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmVenda: TdtmVenda;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmVenda.DataModuleCreate(Sender: TObject);
begin
  qryCliente.Open;
  qryProduto.Open;
  cdsItensVenda.CreateDataSet;
end;

procedure TdtmVenda.DataModuleDestroy(Sender: TObject);
begin
  qryCliente.Close;
  qryProduto.Close;
  cdsItensVenda.Close;
end;

end.
