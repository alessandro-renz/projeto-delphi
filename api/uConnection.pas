unit uConnection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQL, FireDAC.Phys.FB, IniFiles, 
  FireDAC.DApt, system.Generics.Collections;

Type TConnection = class
     private
       FConnection: TFDConnection;
       FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
     public
        property Connection: TFDConnection read FConnection write FConnection;
        constructor Create;
        destructor Destroy;
end;

implementation

{ TConnection }

constructor TConnection.Create;
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'db.ini');
  FDPhysMSSQLDriverLink := TFDPhysMSSQLDriverLink.Create(nil);
  FConnection := TFDConnection.Create(nil);
  FConnection.Params.DriverID := iniFile.ReadString('CONEXAO','DriverID', '');
  FConnection.Params.Database := iniFile.ReadString('CONEXAO','Database', '');
  FConnection.Params.username := iniFile.ReadString('CONEXAO','Username', '');
  FConnection.Params.password := iniFile.ReadString('CONEXAO','Password', '');
  FConnection.Params.Add('Server='+iniFile.ReadString('CONEXAO','Server', ''));
  FConnection.LoginPrompt := false;
  try
    FConnection.Connected := true;
  except on E: Exception do
  begin
    FConnection.Free;
    raise Exception.Create('Erro na conexão com o banco: '+E.Message);
  end;
    
  end;
end;

destructor TConnection.Destroy;
begin
  FConnection.Free;
end;

end.
