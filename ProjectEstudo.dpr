program ProjectEstudo;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDtmConexao in 'datamodule\uDtmConexao.pas' {dtmConexao: TDataModule},
  uTelaHeranca in 'heranca\uTelaHeranca.pas' {frmTelaHeranca},
  uCadCategoria in 'cadastros\uCadCategoria.pas' {frmCadCategoria},
  uEnum in 'uEnum.pas',
  cCategoria in 'classes\cCategoria.pas',
  uCadCliente in 'cadastros\uCadCliente.pas' {frmCadCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdtmConexao, dtmConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCadCliente, frmCadCliente);
  Application.Run;
end.
