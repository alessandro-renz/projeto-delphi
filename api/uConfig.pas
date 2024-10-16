unit uConfig;

interface

uses
  System.SysUtils, System.IOUtils,
  IniFiles, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.DApt,
  FireDAC.Comp.Client, system.JSON;

Type TConfig = class
    private
      driverName: string;
      database: string;
      username: string;
      password: string;
      server: string;
      port: string;
      oJson: TJsonObject;
      fdConnect: TFDConnection;
      FQuery: TFDQuery;
      procedure LoadFileDB;
      procedure ConnectDB;
      procedure SetSql(sql: string);
    public
      constructor Create;
      destructor Destroy;override;
    published
      property Sql: string write SetSql;
      property Query: TFDQuery read FQuery;   
         
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
  if not TFile.Exists(filename) then
  begin
    writeLn('Arquivo configurações db não encontrado');
    Abort;
  end;
  
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


procedure TConfig.SetSql(sql: string);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := fdConnect;
  FQuery.SQL.Clear;
  FQuery.SQL.Text := sql;

  try
    FQuery.Open;    
  except
    on E:Exception do
    begin
        Writeln('Erro na query: '+E.Message);
        FQuery.Close;
        FQuery.Free;
    end;
      
  end;  
end;


destructor TConfig.Destroy;
begin
  fdConnect.Free;
end;

end.
