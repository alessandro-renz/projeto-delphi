unit uRelatorioBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDtmConexao,
  Vcl.Imaging.pngimage;

type
  TfrmRelatorioBase = class(TForm)
    relMain: TRLReport;
    RLBand1: TRLBand;
    lblTitle: TRLLabel;
    RLBand2: TRLBand;
    coluna1: TRLLabel;
    coluna2: TRLLabel;
    coluna3: TRLLabel;
    RLBand3: TRLBand;
    qryRelatorio: TFDQuery;
    dsRelatorio: TDataSource;
    RLDraw1: TRLDraw;
    dbField1: TRLDBText;
    dbField2: TRLDBText;
    dbField3: TRLDBText;
    RLBand4: TRLBand;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLImage1: TRLImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioBase: TfrmRelatorioBase;

implementation

{$R *.dfm}

end.
