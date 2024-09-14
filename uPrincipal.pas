unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDtmConexao, uCadCategoria, uCadCliente, uCadProduto,
  Vcl.StdCtrls, Vcl.Mask, RxToolEdit;

type
  TfrmPrincipal = class(TForm)
    MainPrincipal: TMainMenu;
    CADASTRO1: TMenuItem;
    MOVIMENTAO1: TMenuItem;
    RELATRIOS1: TMenuItem;
    CLIENTE1: TMenuItem;
    N1: TMenuItem;
    CATEGORIA1: TMenuItem;
    PRODUTO1: TMenuItem;
    N2: TMenuItem;
    FECHAR1: TMenuItem;
    VENDA1: TMenuItem;
    CLIENTE2: TMenuItem;
    N3: TMenuItem;
    PRODUTO2: TMenuItem;
    N4: TMenuItem;
    VENDAPORDATA1: TMenuItem;
    procedure FECHAR1Click(Sender: TObject);
    procedure CATEGORIA1Click(Sender: TObject);
    procedure CLIENTE1Click(Sender: TObject);
    procedure PRODUTO1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.CATEGORIA1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;
end;

procedure TfrmPrincipal.CLIENTE1Click(Sender: TObject);
begin
  frmCadCliente := TfrmCadCliente.Create(self);
  frmCadCliente.ShowModal;
  frmCadCliente.Release;
end;

procedure TfrmPrincipal.FECHAR1Click(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;


procedure TfrmPrincipal.PRODUTO1Click(Sender: TObject);
begin
  frmCadProduto := TfrmCadProduto.create(self);
  frmCadProduto.ShowModal;
  frmCadProduto.Release;
end;

end.
