inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de produtos'
  ClientHeight = 503
  ClientWidth = 943
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    Width = 943
    Height = 462
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      ExplicitWidth = 935
      ExplicitHeight = 432
      inherited Panel1: TPanel
        Width = 935
      end
      inherited grdListagem: TDBGrid
        Width = 935
        Height = 367
        Columns = <
          item
            Expanded = False
            FieldName = 'PRODUTOID'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QUANTIDADE'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CATEGORIA'
            Width = 150
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 935
      ExplicitHeight = 432
      object Label1: TLabel
        Left = 24
        Top = 269
        Width = 26
        Height = 15
        Caption = 'Valor'
      end
      object Label2: TLabel
        Left = 352
        Top = 269
        Width = 51
        Height = 15
        Caption = 'Categoria'
      end
      object Label3: TLabel
        Left = 192
        Top = 269
        Width = 62
        Height = 15
        Caption = 'Quantidade'
      end
      object Label4: TLabel
        Left = 24
        Top = 147
        Width = 51
        Height = 15
        Caption = 'Descri'#231#227'o'
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 24
        Top = 105
        Width = 593
        Height = 23
        EditLabel.Width = 33
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome'
        MaxLength = 59
        TabOrder = 1
        Text = ''
      end
      object edtCodigo: TLabeledEdit
        Tag = 1
        Left = 24
        Top = 48
        Width = 121
        Height = 23
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
        Text = ''
      end
      object edtValor: TCurrencyEdit
        Left = 24
        Top = 288
        Width = 121
        Height = 23
        TabOrder = 3
      end
      object lkpCategoria: TDBLookupComboBox
        Left = 352
        Top = 288
        Width = 265
        Height = 23
        KeyField = 'CATEGORIAID'
        ListField = 'DESCRICAO'
        ListSource = dtsCategoria
        TabOrder = 5
      end
      object edtQuantidade: TCurrencyEdit
        Left = 192
        Top = 288
        Width = 121
        Height = 23
        DisplayFormat = '0.00;-0.00'
        TabOrder = 4
      end
      object edtDescricao: TMemo
        Left = 24
        Top = 166
        Width = 593
        Height = 89
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 462
    Width = 943
    DesignSize = (
      943
      41)
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited btnFechar: TBitBtn
      Left = 827
    end
  end
  inherited qryListagem: TFDQuery
    SQL.Strings = (
      
        'Select p.PRODUTOID, p.NOME, p.DESCRICAO, p.VALOR, p.QUANTIDADE, ' +
        'c.descricao as categoria'
      '    from produtos as p'
      '    LEFT JOIN CATEGORIAS AS C ON C.categoriaid = p.categoriaid'
      '')
    object qryListagemPRODUTOID: TIntegerField
      DisplayLabel = 'CODIGO'
      FieldName = 'PRODUTOID'
      Origin = 'PRODUTOID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryListagemNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 255
    end
    object qryListagemDESCRICAO: TStringField
      DisplayLabel = 'DESCRI'#199#195'O'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 255
    end
    object qryListagemVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      currency = True
      Precision = 18
      Size = 5
    end
    object qryListagemQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Precision = 18
      Size = 5
    end
    object qryListagemCATEGORIA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CATEGORIA'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
  end
  object qryCategoria: TFDQuery
    Active = True
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'SELECT CATEGORIAID, DESCRICAO FROM CATEGORIAS')
    Left = 732
    Top = 242
    object qryCategoriaCATEGORIAID: TIntegerField
      FieldName = 'CATEGORIAID'
      Origin = 'CATEGORIAID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCategoriaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 60
    end
  end
  object dtsCategoria: TDataSource
    DataSet = qryCategoria
    Left = 660
    Top = 242
  end
end
