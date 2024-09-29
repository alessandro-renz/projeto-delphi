unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons, uDtmConexao, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Hash, uPrincipal;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    edtUser: TLabeledEdit;
    edtPass: TLabeledEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    qryLogin: TFDQuery;
    procedure BitBtn1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.BitBtn1Click(Sender: TObject);
var
  user, pass: string;
  oHash: THashMD5;
begin
  pass := Trim(edtPass.Text);
  user := Trim(edtUser.Text);
  if (user = EmptyStr) OR (pass = EmptyStr) then
  begin
    ShowMessage('Preencha os campos de login!');
    Exit;
  end;
     
  oHash := oHash.Create;
  pass := oHash.GetHashString(pass);

  qryLogin.SQL.Clear;
  qryLogin.SQL.Text := 'SELECT LOWER(LOGIN), PASS FROM USUARIOS WHERE LOGIN=:LOGIN AND PASS=:PASS';
  qryLogin.ParamByName('LOGIN').AsString := UpperCase(user);
  qryLogin.ParamByName('PASS').AsString := pass;

  try
    qryLogin.Open;
    if qryLogin.RecordCount = 1 then
    begin
      ShowMessage('login com sucesso!');
      self.Destroy;
      frmPrincipal := TfrmPrincipal.Create(nil);
      frmPrincipal.ShowModal;
      frmPrincipal.Release;
    end
    else
      ShowMessage('Usuario ou senha incorreto(s)!'); 
         
  except on E: Exception do
  begin
      ShowMessage(E.Message);
      qryLogin.Close;
  end;
      
  end;
end;

end.
