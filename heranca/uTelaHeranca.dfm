object frmTelaHeranca: TfrmTelaHeranca
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tela Heran'#231'a'
  ClientHeight = 505
  ClientWidth = 954
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 954
    Height = 464
    ActivePage = tabListagem
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 950
    ExplicitHeight = 463
    object tabListagem: TTabSheet
      Caption = 'Listagem'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 946
        Height = 65
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Panel1'
        TabOrder = 0
        ExplicitWidth = 942
        object mskEdit: TMaskEdit
          Left = 10
          Top = 20
          Width = 393
          Height = 23
          TabOrder = 0
          Text = ''
          TextHint = 'Digite Sua Pesquisa'
        end
        object btnPesquisar: TBitBtn
          Left = 409
          Top = 20
          Width = 96
          Height = 25
          Caption = '&Pesquisar'
          TabOrder = 1
        end
      end
      object grdListagem: TDBGrid
        Left = 0
        Top = 65
        Width = 946
        Height = 369
        Align = alClient
        DataSource = dtsListagem
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
    object tabManutencao: TTabSheet
      Caption = 'Manuten'#231#227'o'
      ImageIndex = 1
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 464
    Width = 954
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 463
    ExplicitWidth = 950
    DesignSize = (
      954
      41)
    object btnNovo: TBitBtn
      Left = 6
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Novo'
      TabOrder = 0
    end
    object btnAlterar: TBitBtn
      Left = 87
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Alterar'
      TabOrder = 1
    end
    object btnCancelar: TBitBtn
      Left = 171
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 2
    end
    object btnApagar: TBitBtn
      Left = 338
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Apaga&r'
      TabOrder = 3
    end
    object btnGravar: TBitBtn
      Left = 254
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Gravar'
      TabOrder = 4
    end
    object btnNavigator: TDBNavigator
      Left = 430
      Top = 8
      Width = 224
      Height = 25
      DataSource = dtsListagem
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 5
    end
    object btnFechar: TBitBtn
      Left = 871
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Fechar'
      TabOrder = 6
      ExplicitLeft = 867
    end
  end
  object dtsListagem: TDataSource
    DataSet = qryListagem
    Left = 620
    Top = 34
  end
  object qryListagem: TFDQuery
    Connection = dtmConexao.FDConnection
    Left = 692
    Top = 34
  end
end
