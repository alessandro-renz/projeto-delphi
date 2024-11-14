object dtmConexao: TdtmConexao
  Height = 302
  Width = 565
  object FDConnection: TFDConnection
    ConnectionName = 'connectFD'
    Params.Strings = (
      'Database=ESTOQUE'
      'User_Name=SA'
      'Password=SenhaSegura@123'
      'Server=localhost, 1431'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 64
    Top = 24
  end
end
