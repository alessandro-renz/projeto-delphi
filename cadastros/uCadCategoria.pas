unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, uEnum, cCategoria, uDtmConexao;


type
  TfrmCadCategoria = class(TfrmTelaHeranca)
    qryListagemCATEGORIAID: TIntegerField;
    qryListagemDESCRICAO: TStringField;
    lblTitle: TLabel;
    edtCodigo: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    oCategoria: TCategoria;
  public
    { Public declarations }
    function Apagar: boolean; Override;
    function Gravar(estado: TEstadoCadastro): boolean; Override;
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  oCategoria := TCategoria.Create(dtmConexao.FDConnection);
  IndiceAtual := 'DESCRICAO';

end;

procedure TfrmCadCategoria.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(oCategoria) then
     FreeAndNil(oCategoria);
end;

procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
  if oCategoria.Selecionar(qryListagemCATEGORIAID.AsInteger) then
  begin
    edtCodigo.Text := Trim(qryListagemCATEGORIAID.AsString);
    edtDescricao.Text := Trim(qryListagemDESCRICAO.AsString);
  end
  else
  begin
    Abort;
  end;

  inherited;

end;

procedure TfrmCadCategoria.btnApagarClick(Sender: TObject);
begin
  if oCategoria.Selecionar(qryListagemCATEGORIAID.AsInteger) then
  begin
    oCategoria.Apagar;
  end
  else
  begin
    Abort;
  end;

  inherited;
end;


function TfrmCadCategoria.Gravar(estado: TEstadoCadastro): boolean;
begin
  if edtCodigo.Text <> EmptyStr then
     oCategoria.Codigo := StrToInt(edtCodigo.Text);
  oCategoria.Descricao := edtDescricao.Text;

  if (estado = ecInserir) AND (oCategoria.Inserir) then
  begin
    ShowMessage('Categoria adicionada com sucesso!');
    Abort;
  end;

  if oCategoria.Atualizar then
     ShowMessage('Categoria editada com sucesso!');
end;


function TfrmCadCategoria.Apagar: boolean;
begin

end;

end.
