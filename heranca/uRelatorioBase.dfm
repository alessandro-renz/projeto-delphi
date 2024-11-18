object frmRelatorioBase: TfrmRelatorioBase
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio'
  ClientHeight = 745
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object qryRelatorio: TFDQuery
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'SELECT PRODUTOID, NOME, VALOR FROM PRODUTOS')
    Left = 648
    Top = 472
  end
  object dsRelatorio: TDataSource
    DataSet = qryRelatorio
    Left = 568
    Top = 472
  end
end
