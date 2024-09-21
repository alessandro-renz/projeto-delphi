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
  object relMain: TRLReport
    Left = 0
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dsRelatorio
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 35
      BandType = btHeader
      object lblTitle: TRLLabel
        Left = 296
        Top = 13
        Width = 80
        Height = 16
        Alignment = taCenter
        Caption = 'RELAT'#211'RIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 73
      Width = 718
      Height = 40
      BandType = btColumnHeader
      object coluna1: TRLLabel
        Left = 40
        Top = 15
        Width = 68
        Height = 17
        Caption = 'COLUNA 1'
      end
      object coluna2: TRLLabel
        Left = 177
        Top = 15
        Width = 68
        Height = 17
        Caption = 'COLUNA 2'
      end
      object coluna3: TRLLabel
        Left = 377
        Top = 17
        Width = 68
        Height = 17
        Caption = 'COLUNA 3'
      end
      object RLDraw1: TRLDraw
        Left = 40
        Top = 32
        Width = 641
        Height = 5
        DrawKind = dkLine
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 113
      Width = 718
      Height = 40
      object dbField1: TRLDBText
        Left = 40
        Top = 14
        Width = 79
        Height = 16
        DataField = 'PRODUTOID'
        DataSource = dsRelatorio
        Text = ''
      end
      object dbField2: TRLDBText
        Left = 177
        Top = 14
        Width = 43
        Height = 16
        DataField = 'NOME'
        DataSource = dsRelatorio
        Text = ''
      end
      object dbField3: TRLDBText
        Left = 377
        Top = 14
        Width = 48
        Height = 16
        DataField = 'VALOR'
        DataSource = dsRelatorio
        Text = ''
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 153
      Width = 718
      Height = 56
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 40
        Top = 18
        Width = 641
        Height = 5
        DrawKind = dkLine
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 40
        Top = 25
        Width = 39
        Height = 16
        Text = ''
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 666
        Top = 25
        Width = 15
        Height = 16
        Info = itPageNumber
        Text = ''
      end
    end
  end
  object qryRelatorio: TFDQuery
    Active = True
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
