unit uConfig;

interface

uses
  System.SysUtils,
  IniFiles, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.DApt,
  FireDAC.Comp.Client;

Type TConfig = class
    private
      fdConnect: TFDConnection;
      driverName: string;
      database: string;
      username: string;
      password: string;
      server: string;
      port: string;
      procedure LoadFileDB;
      procedure ConnectDB;
      procedure SetSql(value: string);
    public
      constructor Create;
      destructor Destroy;override;

    published
      property Sql: string write SetSql; 
end;

implementation

{ TConfig }

constructor TConfig.Create;
begin
  LoadFileDB;
  ConnectDB; 
end;


procedure TConfig.LoadFileDB;
var
  fileIni: TIniFile;
  filename: string;
begin
  filename := GetCurrentDir + '\db.ini';
  try
    fileIni := TIniFile.Create(filename);
    driverName := fileIni.ReadString('conexao', 'DriverName', '');
    database := fileIni.ReadString('conexao', 'Database', '');
    username := fileIni.ReadString('conexao', 'Username', '');
    password := fileIni.ReadString('conexao', 'Password', '');
    server := fileIni.ReadString('conexao', 'Server', '');
    port := fileIni.ReadString('conexao', 'Port', '');
  except on E: Exception do
       writeLn(E.Message);
  end;

end;


procedure TConfig.ConnectDB;
begin
    try
      fdConnect := TFDConnection.Create(nil);
      fdConnect.LoginPrompt := false;
      fdConnect.DriverName := self.driverName;
      fdConnect.Params.Database := self.database;
      fdConnect.Params.UserName := self.username;
      fdConnect.Params.Password := self.password;
      fdConnect.Params.Add('Server='+self.server);
      fdConnect.Params.Add('Port='+self.port);
      fdConnect.Open;
    except
      on E:Exception do
        writeLn('Erro na conexão do db: ' + E.Message);
    end;
end;


procedure TConfig.SetSql(value: string);
var
  query: TFDQuery;
begin
  if fdConnect.InTransaction then
       fdConnect.Commit;
    fdConnect.StartTransaction;
    
  try
    query := TFDQuery.Create(nil);
    query.Connection := fdConnect;
    query.SQL.Clear; 
    query.SQL.Text := value;
  except on E: Exception do
    writeLn('Erro na query: ' + E.Message);
  end;
  
end;


destructor TConfig.Destroy;
begin
  fdConnect.Free;
end;

end.
