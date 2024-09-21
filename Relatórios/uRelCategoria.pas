unit uRelCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, uDtmConexao,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, RLFilters, RLPDFFilter;

type
  TfrmRelCategoria = class(TForm)
    relatorio: TRLReport;
    qryCategorias: TFDQuery;
    dsCategorias: TDataSource;
    RLBand1: TRLBand;
    lblTitle: TRLLabel;
    RLDraw1: TRLDraw;
    RLBand2: TRLBand;
    lblCodigo: TRLDBText;
    RLDBText1: TRLDBText;
    RLBand3: TRLBand;
    RLDraw2: TRLDraw;
    RLPDFFilter1: TRLPDFFilter;
    systemData: TRLSystemInfo;
    systemPage: TRLSystemInfo;
    RLLabel3: TRLLabel;
    qryCategoriasCATEGORIAID: TIntegerField;
    qryCategoriasDESCRICAO: TStringField;
    RLBand4: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCategoria: TfrmRelCategoria;

implementation

{$R *.dfm}

procedure TfrmRelCategoria.FormCreate(Sender: TObject);
begin
  qryCategorias.Open;
end;

procedure TfrmRelCategoria.FormDestroy(Sender: TObject);
begin
  qryCategorias.Close;
end;

end.
