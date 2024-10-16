unit uController;

interface

uses
  System.SysUtils, uConfig, Horse, system.JSON;

Type TController = class
    public
      constructor Create;
      destructor Destroy;override;
      procedure GetMotores(Req: THorseRequest; Res: THorseResponse);
      procedure GetCores(Req: THorseRequest; Res: THorseResponse);
    private
      oConfig: TConfig;

end;

implementation

{ TController }

constructor TController.Create;
begin
    oConfig := TConfig.Create;
end;

procedure TController.GetMotores(Req: THorseRequest; Res: THorseResponse);
var
  oJson: TJSONObject;
  jsonArray: TJSONArray;
begin
    oJson := TJSONObject.Create;
    oConfig.Sql := 'SELECT MTR_NOME FROM FROT_MOTORES;';
    oConfig.Query.First;
    while not oConfig.Query.eof do
    begin
      oJson.AddPair('motor', oConfig.Query.FieldByName('MTR_NOME').AsString);
      oConfig.Query.Next;
    end;
    jsonArray := TJSONArray.Create;
    jsonArray.AddElement(oJson);
    oConfig.Query.Close;
    Res.Send(jsonArray.ToJSON);
end;

procedure TController.GetCores(Req: THorseRequest; Res: THorseResponse);
var
  oJson: TJSONObject;
  jsonArray:TJSONArray;
begin
    oJson := TJSONObject.Create;
    oConfig.Sql := 'SELECT COR_NOME FROM FROT_CORES;';
    oConfig.Query.First;
    while not oConfig.Query.eof do
    begin
      oJson.AddPair('cor', oConfig.Query.FieldByName('COR_NOME').AsString);
      oConfig.Query.Next;
    end;
    jsonArray := TJSONArray.Create;
    jsonArray.AddElement(oJson);
    oConfig.Query.Close;
    Res.Send(jsonArray.ToJSON);
end;


destructor TController.Destroy;
begin
  oConfig.Free;
end;

end.
