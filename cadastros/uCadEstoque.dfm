inherited frmCadEstoque: TfrmCadEstoque
  Caption = 'Tela Estoque'
  OnDestroy = FormDestroy
  ExplicitWidth = 951
  ExplicitHeight = 540
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      ExplicitWidth = 931
      ExplicitHeight = 431
      inherited Panel1: TPanel
        ExplicitWidth = 935
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 931
      ExplicitHeight = 431
      object Label1: TLabel
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
      object Label3: TLabel
        Left = 24
        Top = 126
        Width = 116
        Height = 15
        Caption = 'Adicionar Quantidade'
      end
      object Label4: TLabel
        Left = 24
        Top = 190
        Width = 111
        Height = 15
        Caption = '*Quantidade M'#237'nima'
      end
      object Label5: TLabel
        Left = 24
        Top = 408
        Width = 459
        Height = 15
        Caption = 
          '*o n'#250'mero da quantidade m'#237'nima '#233' para o sistema exibir mensagens' +
          ' de estoque baixo!'
      end
      object edtQuantidade: TCurrencyEdit
        Left = 24
        Top = 144
        Width = 121
        Height = 23
        DisplayFormat = '0.00'
        TabOrder = 0
      end
      object edtQuantidadeMinima: TCurrencyEdit
        Left = 24
        Top = 208
        Width = 121
        Height = 23
        DisplayFormat = '0.00'
        TabOrder = 1
      end
      object edtProduto: TLabeledEdit
        Left = 24
        Top = 81
        Width = 292
        Height = 23
        EditLabel.Width = 43
        EditLabel.Height = 15
        EditLabel.Caption = 'Produto'
        ParentColor = True
        ReadOnly = True
        TabOrder = 2
        Text = ''
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnNovo: TBitBtn
      Left = 656
      Top = 6
      Width = 133
      Caption = 'Atualizar Estoque'
      Visible = False
      ExplicitLeft = 656
      ExplicitTop = 6
      ExplicitWidth = 133
    end
    inherited btnAlterar: TBitBtn
      Left = 4
      Top = 6
      Width = 125
      Caption = '&Alterar Estoque'
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 125
    end
    inherited btnCancelar: TBitBtn
      Left = 154
      Top = 6
      ExplicitLeft = 154
      ExplicitTop = 6
    end
    inherited btnApagar: TBitBtn
      Left = 432
      Top = 6
      Visible = False
      ExplicitLeft = 432
      ExplicitTop = 6
    end
    inherited btnGravar: TBitBtn
      Left = 240
      Top = 6
      ExplicitLeft = 240
      ExplicitTop = 6
    end
    inherited btnNavigator: TDBNavigator
      Left = 510
      Hints.Strings = ()
      Visible = False
      ExplicitLeft = 510
    end
    inherited btnFechar: TBitBtn
      Left = 819
      ExplicitLeft = 815
    end
  end
  inherited dtsListagem: TDataSource
    Left = 780
    Top = 18
  end
  inherited qryListagem: TFDQuery
    SQL.Strings = (
      
        'SELECT P.PRODUTOID, P.NOME, E.QUANTIDADE, E.QUANTIDADE_MINIMA,E.' +
        'ULTIMA_ENTRADA FROM ESTOQUE AS E'
      'LEFT JOIN PRODUTOS AS P ON P.PRODUTOID = E.PRODUTOID'
      'ORDER BY E.ULTIMA_ENTRADA DESC;'
      '')
    Left = 856
    Top = 18
    object qryListagemPRODUTOID: TIntegerField
      DisplayLabel = 'CODIGO PRODUTO'
      DisplayWidth = 17
      FieldName = 'PRODUTOID'
      Origin = 'PRODUTOID'
    end
    object qryListagemNOME: TStringField
      DisplayLabel = 'PRODUTO'
      DisplayWidth = 66
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 255
    end
    object qryListagemQUANTIDADE: TFMTBCDField
      DisplayWidth = 19
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Required = True
      Precision = 18
      Size = 2
    end
    object qryListagemULTIMA_ENTRADA: TSQLTimeStampField
      DisplayLabel = 'ULTIMA ENTRADA'
      DisplayWidth = 34
      FieldName = 'ULTIMA_ENTRADA'
      Origin = 'ULTIMA_ENTRADA'
    end
    object qryListagemQUANTIDADE_MINIMA: TFMTBCDField
      FieldName = 'QUANTIDADE_MINIMA'
      Origin = 'QUANTIDADE_MINIMA'
      Precision = 18
      Size = 2
    end
  end
end
