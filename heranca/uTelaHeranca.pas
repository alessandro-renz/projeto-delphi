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
    procedure grdListagemDblClick(Sender: TObject);
    procedure pgcPrincipalChange(Sender: TObject);
  private
    { Private declarations }

    procedure ControleButtons;
    procedure TrocarAba;
    procedure DesabilitarEditPK;
    function ExisteCampoObrigatorio: boolean;
    procedure LimparEdits;
  public
    { Public declarations }
    Estado: TEstadoCadastro;
    IndiceAtual: string;
    function Apagar: boolean; Virtual;
    function Gravar(estado: TEstadoCadastro): boolean; Virtual;
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  pgcPrincipal.ActivePageIndex := 0;
  Estado := ecNenhum;
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

  DesabilitarEditPK;
end;

function TfrmTelaHeranca.Gravar(estado: TEstadoCadastro): boolean;
begin
  if estado = ecAlterar then
    ShowMessage('ALTERAR')
  else if estado = ecInserir then
    ShowMessage('Inserir');

  Result := True;
end;

{
  Tag 1: É o campo primario
  Tag 2: Significa que o campo é obrigatório
}
function TfrmTelaHeranca.ExisteCampoObrigatorio: boolean;
var i: integer;
begin
  Result := false;
  for i := 0 to ComponentCount - 1 do
  begin
      if not(Components[i] is TLabeledEdit) then
      begin
        Continue;
      end;
      if (TLabeledEdit(Components[i]).Tag = 2) AND (TLabeledEdit(Components[i]).Text = EmptyStr) then
      begin
        MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption + ' é um campo obrigatório!', TMsgDlgType.mtInformation, [mbOk], 0);
        TLabeledEdit(Components[i]).SetFocus;
        Result := True;
        Break;
      end;
  end;

end;


procedure TfrmTelaHeranca.DesabilitarEditPK;
var i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
      if not(Components[i] is TLabeledEdit) then
      begin
        Continue;
      end;
      if (TLabeledEdit(Components[i]).Tag = 1) then
      begin
        TLabeledEdit(Components[i]).Enabled := false;
        Break;
      end;
  end;
end;


procedure TfrmTelaHeranca.LimparEdits;
var i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
      if (Components[i] is TLabeledEdit) then
      begin
          TLabeledEdit(Components[i]).Text := EmptyStr;
      end;
  end;
end;


function TfrmTelaHeranca.Apagar: boolean;
begin
  Result := True;
end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
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

procedure TfrmTelaHeranca.pgcPrincipalChange(Sender: TObject);
begin
  if Estado = ecNenhum then
    pgcPrincipal.ActivePageIndex := 0;
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  Estado := ecAlterar;
  ControleButtons;
  TrocarAba;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  LimparEdits;
  qryListagem.Refresh;
  grdListagem.Refresh;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  Estado := ecNenhum;
  ControleButtons;
  LimparEdits;
  TrocarAba;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  LimparEdits;
  Close;
end;


procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if ExisteCampoObrigatorio then
    Abort;

  Gravar(Estado);
  qryListagem.Refresh;
  grdListagem.Refresh;
  Estado := ecNenhum;
  ControleButtons;
  TrocarAba;
end;

procedure TfrmTelaHeranca.ControleButtons;
begin
  btnNovo.Enabled := (Estado = ecNenhum);
  btnAlterar.Enabled := (Estado = ecNenhum);
  btnCancelar.Enabled := (Estado <> ecNenhum);
  btnGravar.Enabled := (Estado <> ecNenhum);
  btnApagar.Enabled := (Estado = ecNenhum);
  btnNavigator.Enabled := (Estado = ecNenhum);
end;


procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  Estado := ecInserir;
  ControleButtons;
  LimparEdits;
  TrocarAba;
end;


procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryListagem.Close;
  Close;
end;


procedure TfrmTelaHeranca.TrocarAba;
begin
  if (Estado = ecInserir) OR (Estado = ecAlterar) then
  begin
     pgcPrincipal.ActivePageIndex := 1;
     Abort;
  end;
  pgcPrincipal.ActivePageIndex := 0;

end;

end.
