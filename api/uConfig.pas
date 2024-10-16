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
      FJsonArray: TJsonArray;
      procedure LoadFileDB;
      procedure ConnectDB;
      procedure SetSql(sql: string);
      function GetJson: string;
    public
      constructor Create;
      destructor Destroy;override;
    published
      property Sql: string write SetSql;
      property Query: TFDQuery read FQuery;
      property Json: string read GetJson;

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


function TConfig.GetJson: string;
begin
  Result := FJsonArray.ToJSON;
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
var
  oJson: TJsonObject;
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := fdConnect;
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Text := sql;
  oJson := TJsonObject.Create;
  FJsonArray := TJsonArray.Create;
  try
    FQuery.Open;
    FQuery.First;
    while not FQuery.Eof do
    begin
      for var I := 0 to FQuery.FieldCount - 1 do
      begin
        oJson.AddPair(FQuery.Fields[I].FieldName, FQuery.Fields[I].AsString);
      end;

      FJsonArray.AddElement(oJson);
      FQuery.Next;
    end;

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
