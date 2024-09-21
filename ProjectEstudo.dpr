program ProjectEstudo;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDtmConexao in 'datamodule\uDtmConexao.pas' {dtmConexao: TDataModule},
  uTelaHeranca in 'heranca\uTelaHeranca.pas' {frmTelaHeranca},
  uCadCategoria in 'cadastros\uCadCategoria.pas' {frmCadCategoria},
  uEnum in 'uEnum.pas',
  cCategoria in 'classes\cCategoria.pas',
  uCadCliente in 'cadastros\uCadCliente.pas' {frmCadCliente},
  cCliente in 'classes\cCliente.pas',
  uCadProduto in 'cadastros\uCadProduto.pas' {frmCadProduto},
  cProduto in 'classes\cProduto.pas',
  uDtmVenda in 'datamodule\uDtmVenda.pas' {dtmVenda: TDataModule},
  uCadVenda in 'cadastros\uCadVenda.pas' {frmCadVenda},
  cVenda in 'classes\cVenda.pas',
  uRelCategoria in 'Relatórios\uRelCategoria.pas' {frmRelCategoria},
  uCadEstoque in 'cadastros\uCadEstoque.pas' {frmCadEstoque},
  cEstoque in 'classes\cEstoque.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdtmConexao, dtmConexao);
  Application.CreateForm(TdtmVenda, dtmVenda);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmRelCategoria, frmRelCategoria);
  Application.CreateForm(TfrmCadEstoque, frmCadEstoque);
  Application.Run;
end.
