unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, RxToolEdit;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

end.
