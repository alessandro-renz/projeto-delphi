object dtmConexao: TdtmConexao
  Height = 302
  Width = 565
  object FDConnection: TFDConnection
    ConnectionName = 'connectFD'
    Params.Strings = (
      'Database=C:\Users\sandr\Documents\BD Firebird\DADOS.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 24
  end
end
