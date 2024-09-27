unit uApi;

interface

uses System.JSON, System.SysUtils, System.Variants, System.Classes, System.Net.HttpClient, System.Net.HttpClientComponent;

Type TApi = class
    public
      constructor Create(urlBase: string);
      procedure AddHeader(header: string; value: string);
      function Get(endpoint: string): boolean;
      function Post(endpoint: string; body: TJSONObject): boolean;
      function Put(endpoint: string; body: TJSONObject): boolean;
      function Delete(endpoint: string): boolean;
      destructor Destroy;
    private
      FStatus: integer;
      Url: string;
      HttpClient: TNetHTTPClient;
      httpResponse: IHTTPResponse;
      FResponse: TJSONObject;
    
    published
      property Status: integer read FStatus write FStatus;
      property Response: TJSONObject read FResponse write FResponse;
end;

implementation

{ TApi }

constructor TApi.Create(urlBase: string);
begin
  Url := urlBase;
  HttpClient := TNetHTTPClient.Create(nil);
  HttpClient.ContentType := 'application/json';
  HttpClient.Accept := 'application/json';
end;


function TApi.Get(endpoint: string): boolean;
begin
  Url := Url + endpoint;

  try
    httpResponse := HttpClient.Get(Url);
    FResponse := TJSONObject.ParseJSONValue(httpResponse.ContentAsString) as TJSONObject;
    Result := True;
  except
    on e: Exception do
    begin
      FResponse := TJSONObject.ParseJSONValue('{error: '+ e.Message +'}') as TJSONObject;
      Result := False;
    end;
  end;

end;


procedure TApi.AddHeader(header: string; value: string);
begin
    HttpClient.CustomHeaders[header] := value;
end;


function TApi.Post(endpoint: string; body: TJSONObject): boolean;
begin
  Url := Url + endpoint;

  try
    httpResponse := HttpClient.Post(Url, body.ToString);
    FResponse :=  TJSONObject.ParseJSONValue(httpResponse.ContentAsString) as TJSONObject;
    Result := True;
  except on e: Exception do
  begin
    FResponse := TJSONObject.ParseJSONValue('{error: '+e.Message+'}') as TJSONObject;
    Result := False;
  end;

  end;
end;


function TApi.Put(endpoint: string; body: TJSONObject): boolean;
begin
  Url := Url + endpoint;

  try
    HttpResponse := HttpClient.Put(Url, body.ToString);  
    FResponse := TJSONObject.ParseJSONValue(httpResponse.ContentAsString) as TJSONObject;
    Result := True;
  except on e: Exception do
  begin
    FResponse := TJSONObject.ParseJSONValue('{error: '+e.Message+'}') as TJSONObject;
    Result := False;
  end;
  
  end;
end;


function TApi.Delete(endpoint: string): boolean;
begin
  Url := Url + endpoint;

  try
    httpResponse := HttpClient.Delete(Url);
    httpResponse.ContentAsString;
    FResponse := TJSONObject.ParseJSONValue(httpResponse.ContentAsString) as TJSONObject;
    Result := True;
  except
    on e: Exception do
    begin
      FResponse := TJSONObject.ParseJSONValue('{error: '+ e.Message +'}') as TJSONObject;
      Result := False;
    end;
  end;
end;


destructor TApi.Destroy;
begin
  if Assigned(httpClient) then
     FreeAndNil(httpClient);
  FResponse.Free;
end;

end.
