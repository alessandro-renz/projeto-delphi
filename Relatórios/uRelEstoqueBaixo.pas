unit uRelEstoqueBaixo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRelatorioBase, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport;

type
  TfrmRelEstoqueBaixo = class(TfrmRelatorioBase)
    RLLabel1: TRLLabel;
    RLDBText1: TRLDBText;
    qryRelatorioQUANTIDADE: TFMTBCDField;
    qryRelatorioQUANTIDADE_MINIMA: TFMTBCDField;
    qryRelatorioULTIMA_ENTRADA: TSQLTimeStampField;
    qryRelatorioPRODUTOID: TIntegerField;
    qryRelatorioNOME: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function isProdutosEstoqueBaixo: boolean;
  end;

var
  frmRelEstoqueBaixo: TfrmRelEstoqueBaixo;

implementation

{$R *.dfm}

function TfrmRelEstoqueBaixo.isProdutosEstoqueBaixo: boolean;
begin
    Result := qryRelatorio.RecordCount > 0;

end;

end.
