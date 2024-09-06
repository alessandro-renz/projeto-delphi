unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Data.DB, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDtmConexao, uEnum;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    Panel1: TPanel;
    mskEdit: TMaskEdit;
    btnPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnApagar: TBitBtn;
    btnGravar: TBitBtn;
    btnNavigator: TDBNavigator;
    btnFechar: TBitBtn;
    dtsListagem: TDataSource;
    qryListagem: TFDQuery;
    Label1: TLabel;
    lblIndice: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskEditChange(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
  private
    { Private declarations }
    estado: TEstadoCadastro;
    procedure ControleButtons;
  public
    { Public declarations }
    IndiceAtual: string;
    function Excluir: boolean; Virtual;
    function Gravar(estado: TEstadoCadastro): boolean; Virtual;
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}


procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  estado := ecNenhum;
  grdListagem.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,
                            dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection,
                            dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  if (qryListagem.SQL.Text <> EmptyStr) then
  begin
    IndiceAtual := lowerCase(IndiceAtual);
    lblIndice.Caption := qryListagem.FieldByName(IndiceAtual).DisplayLabel;
    qryListagem.IndexFieldNames := IndiceAtual;
    qryListagem.Open;
  end;

end;

function TfrmTelaHeranca.Gravar(estado: TEstadoCadastro): boolean;
begin
  if estado = ecAlterar then
    ShowMessage('ALTERAR')
  else if estado = ecInserir then
    ShowMessage('Inserir');

  Result := True;
end;

function TfrmTelaHeranca.Excluir: boolean;
begin
  Result := True;
end;

procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ShowMessage(Key.ToString);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  qryListagem.IndexFieldNames := IndiceAtual;
  lblIndice.Caption := Column.Title.Caption;
end;

procedure TfrmTelaHeranca.mskEditChange(Sender: TObject);
begin
  qryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  estado := ecAlterar;
  ControleButtons;
  pgcPrincipal.ActivePageIndex := 1;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  if Excluir then
    ShowMessage('Excluir');
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  estado := ecNenhum;
  ControleButtons;
  pgcPrincipal.ActivePageIndex := 0;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;


procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  Gravar(estado);

end;

procedure TfrmTelaHeranca.ControleButtons;
begin
  btnNovo.Enabled := (estado = ecNenhum);
  btnAlterar.Enabled := (estado = ecNenhum);
  btnCancelar.Enabled := (estado <> ecNenhum);
  btnGravar.Enabled := (estado <> ecNenhum);
  btnApagar.Enabled := (estado = ecNenhum);
  btnNavigator.Enabled := (estado = ecNenhum);
end;


procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  estado := ecInserir;
  ControleButtons;
  pgcPrincipal.ActivePageIndex := 1;
end;


procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryListagem.Close;
  Close;
end;

end.
