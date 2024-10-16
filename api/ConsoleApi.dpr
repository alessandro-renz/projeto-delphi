program ConsoleApi;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  uController in 'controllers\uController.pas';

var
  oController: TController;
begin
  oController := TController.Create;
  THorse.Get('/motores', oController.GetMotores);

  THorse.Get('/cores', oController.GetCores);

  THorse.Listen(9000);
end.

