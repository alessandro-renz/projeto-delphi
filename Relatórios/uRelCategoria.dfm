object frmRelCategoria: TfrmRelCategoria
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de categorias'
  ClientHeight = 638
  ClientWidth = 859
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object relatorio: TRLReport
    Left = 1
    Top = 1
    Width = 794
    Height = 1123
    DataSource = dsCategorias
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 51
      BandType = btHeader
      Completion = ctMaxBands
      object lblTitle: TRLLabel
        Left = 16
        Top = 11
        Width = 225
        Height = 24
        Caption = 'Relat'#243'rio de categorias'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 16
        Top = 35
        Width = 699
        Height = 10
        Anchors = [fkLeft, fkRight]
        DrawHeight = 2
        DrawKind = dkLine
        DrawWidth = 0
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 113
      Width = 718
      Height = 32
      object lblCodigo: TRLDBText
        Left = 16
        Top = 6
        Width = 91
        Height = 16
        DataField = 'CATEGORIAID'
        DataSource = dsCategorias
        Text = ''
      end
      object RLDBText1: TRLDBText
        Left = 112
        Top = 5
        Width = 80
        Height = 16
        DataField = 'DESCRICAO'
        DataSource = dsCategorias
        Text = ''
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 145
      Width = 718
      Height = 56
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 16
        Top = 22
        Width = 699
        Height = 10
        Anchors = [fkLeft, fkRight]
        DrawHeight = 2
        DrawKind = dkLine
        DrawWidth = 0
      end
      object systemData: TRLSystemInfo
        Left = 16
        Top = 31
        Width = 39
        Height = 16
        Anchors = [fkLeft, fkTop]
        Text = ''
      end
      object systemPage: TRLSystemInfo
        Left = 696
        Top = 31
        Width = 20
        Height = 16
        Anchors = [fkTop, fkRight]
        Info = itPageNumber
        Text = ''
      end
      object RLLabel3: TRLLabel
        Left = 650
        Top = 31
        Width = 48
        Height = 16
        Anchors = [fkTop, fkRight]
        Caption = 'P'#225'gina:'
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 89
      Width = 718
      Height = 24
      BandType = btColumnHeader
      object RLLabel1: TRLLabel
        Left = 16
        Top = 4
        Width = 55
        Height = 16
        Caption = 'C'#211'DIGO'
      end
      object RLLabel2: TRLLabel
        Left = 112
        Top = 4
        Width = 80
        Height = 16
        Caption = 'DESCRI'#199#195'O'
      end
    end
  end
  object qryCategorias: TFDQuery
    Active = True
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'SELECT CATEGORIAID, DESCRICAO FROM CATEGORIAS')
    Left = 816
    Top = 80
    object qryCategoriasCATEGORIAID: TIntegerField
      FieldName = 'CATEGORIAID'
      Origin = 'CATEGORIAID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCategoriasDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 60
    end
  end
  object dsCategorias: TDataSource
    DataSet = qryCategorias
    Left = 816
    Top = 152
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0.1.2 \251 Copyright '#169' 1999-20' +
      '21 Fortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 721
    Top = 529
  end
end
