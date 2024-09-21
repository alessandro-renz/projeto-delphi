inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de produtos'
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      inherited Panel1: TPanel
        ExplicitWidth = 935
      end
      inherited grdListagem: TDBGrid
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
            FieldName = 'CATEGORIA'
            Width = 150
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      object Label1: TLabel
        Left = 24
        Top = 269
        Width = 26
        Height = 15
        Caption = 'Valor'
      end
      object Label2: TLabel
        Left = 176
        Top = 269
        Width = 51
        Height = 15
        Caption = 'Categoria'
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
        Left = 176
        Top = 288
        Width = 441
        Height = 23
        KeyField = 'CATEGORIAID'
        ListField = 'DESCRICAO'
        ListSource = dtsCategoria
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
    object tabEstoque: TTabSheet
      Caption = 'tabEstoque'
      ImageIndex = 2
      object Label3: TLabel
        Left = 24
        Top = 16
        Width = 71
        Height = 21
        Caption = 'ESTOQUE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 24
        Top = 54
        Width = 116
        Height = 15
        Caption = 'Adicionar Quantidade'
      end
      object Label7: TLabel
        Left = 24
        Top = 118
        Width = 111
        Height = 15
        Caption = '*Quantidade M'#237'nima'
      end
      object Label8: TLabel
        Left = 24
        Top = 400
        Width = 459
        Height = 15
        Caption = 
          '*o n'#250'mero da quantidade m'#237'nima '#233' para o sistema exibir mensagens' +
          ' de estoque baixo!'
      end
      object edtQuantidade: TCurrencyEdit
        Left = 24
        Top = 72
        Width = 121
        Height = 23
        DisplayFormat = '0.00'
        TabOrder = 0
      end
      object edtQuantidadeMinima: TCurrencyEdit
        Left = 24
        Top = 136
        Width = 121
        Height = 23
        DisplayFormat = '0.00'
        TabOrder = 1
      end
    end
  end
  inherited pnlRodape: TPanel
    DesignSize = (
      943
      41)
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited btnFechar: TBitBtn
      Left = 819
      ExplicitLeft = 815
    end
  end
  inherited dtsListagem: TDataSource
    Left = 812
  end
  inherited qryListagem: TFDQuery
    SQL.Strings = (
      
        'Select p.PRODUTOID, p.NOME, p.DESCRICAO, p.VALOR, c.descricao as' +
        ' categoria'
      '    from produtos as p'
      '    LEFT JOIN CATEGORIAS AS C ON C.categoriaid = p.categoriaid'
      '')
    Left = 884
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
    Left = 884
    Top = 98
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
    Left = 812
    Top = 98
  end
end
