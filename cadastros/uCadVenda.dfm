inherited frmCadVenda: TfrmCadVenda
  Caption = 'Cadastro da venda'
  ClientHeight = 503
  ClientWidth = 943
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    Width = 943
    Height = 462
    ActivePage = tabManutencao
    inherited tabManutencao: TTabSheet
      object Label1: TLabel
        Left = 176
        Top = 7
        Width = 37
        Height = 15
        Caption = 'Cliente'
      end
      object Label2: TLabel
        Left = 608
        Top = 7
        Width = 59
        Height = 15
        Caption = 'Data Venda'
      end
      object Label3: TLabel
        Left = 32
        Top = 63
        Width = 43
        Height = 15
        Caption = 'Produto'
      end
      object Label4: TLabel
        Left = 360
        Top = 63
        Width = 71
        Height = 15
        Caption = 'Valor Unit'#225'rio'
      end
      object Label5: TLabel
        Left = 504
        Top = 63
        Width = 62
        Height = 15
        Caption = 'Quantidade'
      end
      object lblValorTotalProduto: TLabel
        Left = 632
        Top = 63
        Width = 54
        Height = 15
        Caption = 'Valor Total'
      end
      object edtNumeroVenda: TLabeledEdit
        Tag = 1
        Left = 32
        Top = 24
        Width = 121
        Height = 23
        EditLabel.Width = 79
        EditLabel.Height = 15
        EditLabel.Caption = 'N'#250'mero Venda'
        Enabled = False
        NumbersOnly = True
        TabOrder = 1
        Text = ''
      end
      object lkpCliente: TDBLookupComboBox
        Tag = 1
        Left = 176
        Top = 24
        Width = 409
        Height = 23
        KeyField = 'CLIENTEID'
        ListField = 'NOME'
        ListSource = dtmVenda.dsCliente
        TabOrder = 2
      end
      object edtData: TDateEdit
        Left = 608
        Top = 24
        Width = 121
        Height = 23
        DefaultToday = True
        DialogTitle = 'Selecione a data'
        NumGlyphs = 2
        TabOrder = 3
        Text = '15/09/2024'
      end
      object lkpProduto: TDBLookupComboBox
        Left = 32
        Top = 83
        Width = 303
        Height = 23
        KeyField = 'PRODUTOID'
        ListField = 'NOME'
        ListSource = dtmVenda.dsProduto
        TabOrder = 4
        OnExit = lkpProdutoExit
      end
      object edtUnitario: TCurrencyEdit
        Left = 360
        Top = 83
        Width = 121
        Height = 23
        TabOrder = 5
        OnChange = edtUnitarioChange
      end
      object edtQuantidade: TCurrencyEdit
        Left = 504
        Top = 83
        Width = 105
        Height = 23
        DisplayFormat = '0.00; 0.00'
        TabOrder = 6
        OnChange = edtQuantidadeChange
      end
      object edtValorTotalProduto: TCurrencyEdit
        Left = 632
        Top = 83
        Width = 97
        Height = 23
        ParentColor = True
        ReadOnly = True
        TabOrder = 0
      end
      object btnAddProduto: TBitBtn
        Left = 742
        Top = 78
        Width = 80
        Height = 28
        Caption = 'Adicionar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFC1C1C1
          C1C1C1C1C1C1C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0FF00FFFF00FFFF00FFC7C7C7FEFEFEFCFCFCFCFCFCFCFCFCFCFCFCFC
          FCFCFCFCFCFCFCFCFCFCFCFCFCFCFEFEFEC6C6C6FF00FFFF00FFFF00FFCCCCCC
          FCFCFCF3F3F3F4F4F4F4F4F4F4F4F4F4F4F4F3F3F3F3F3F3F3F3F3F2F2F2FCFC
          FCCBCBCBFF00FFFF00FFFF00FFD1D1D1FDFDFDF5F5F5F5F5F5F5F5F5F5F5F5F5
          F5F5F5F5F5F4F4F4F4F4F4F3F3F3FCFCFCD0D0D0FF00FFFF00FFFF00FFD5D5D5
          FDFDFDF6F6F6F6F6F6F7F7F7F7F7F7F6F6F6F6F6F6F6F6F6F5F5F5F5F5F5FDFD
          FDD4D4D4FF00FFFF00FFFF00FFD7D7D7FDFDFDF7F7F7F8F8F8F8F8F8F8F8F8F8
          F8F8F7F7F7F7F7F7F7F7F7F6F6F6FDFDFDD7D7D7FF00FFFF00FFFF00FFDADADA
          FEFEFEF8F8F8F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F8F8F8F8F8F8F7F7F7FDFD
          FDDADADAFF00FFFF00FFFF00FFDCDCDCFEFEFEF9F9F9FAFAFAFAFAFAFAFAFAFA
          FAFAFAFAFAF9F9F9F9F9F9F8F8F8FDFDFDDCDCDCFF00FFFF00FFFF00FFDDDDDD
          FEFEFEFAFAFAFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFAFAFAFAFAFAF9F9F9FEFE
          FEDDDDDDFF00FFFF00FFFF00FFDEDEDEFEFEFEFBFBFBFCFCFCFCFCFCFCFCFCFC
          FCFCFBFBFBFBFBFBFAFAFAFAFAFAFEFEFEDEDEDEFF00FFFF00FFFF00FFDFDFDF
          FEFEFEFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFBFAFAFAFEFE
          FEDFDFDFFF00FFFF00FFFF00FFDFDFDFFEFEFEFCFCFCFDFDFDFDFDFDFDFDFDFD
          FDFDFDFDFDFCFCFCFCFCFCFBFBFBFEFEFEDFDFDFFF00FFFF00FFFF00FFE0E0E0
          FFFFFFFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFCFCFCE0E0E0E5E5E5EDED
          EDDFDFDFFF00FFFF00FFFF00FFE0E0E0FFFFFFFDFDFDFDFDFDFEFEFEFEFEFEFE
          FEFEFDFDFDFDFDFDE5E5E5F1F1F1E0E0E0FF00FFFF00FFFF00FFFF00FFE0E0E0
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDEDEDEDE0E0E0FF00
          FFFF00FFFF00FFFF00FFFF00FFE0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0
          E0E0E0E0E0E0E0E0E0E0E0FF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 7
        OnClick = btnAddProd
      end
      object btnRemoveProduto: TBitBtn
        Left = 835
        Top = 78
        Width = 80
        Height = 28
        Caption = 'Remover'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          4442BC3C3CAAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0303
          7B02028CFF00FFFF00FFFF00FF514FC52222C83030C84848B7FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF1010870505A10101A204028DFF00FF5959CA2929D2
          1717D01616CE3838D15151BFFF00FFFF00FFFF00FFFF00FF2121940E0EA70101
          A60101A60101A204028D5555C34444DD1C1CDB1B1BD91A1AD53F3FD85757C4FF
          00FFFF00FF3434A41A1AB30202A80101A60101A602029F020278FF00FF6262CF
          4C4CE62121E31F1FDF1C1CDA4242DC5656C44848B72A2AC40A0AB60505AE0101
          A70505A003037BFF00FFFF00FFFF00FF6F6FD85656ED2424E82121E31D1DDD3F
          3FDA3838D31111C50D0DBC0808B40F0FA90D0D80FF00FFFF00FFFF00FFFF00FF
          FF00FF7777DD5959EF2626EA2121E41D1DDC1919D41414CB1010C21C1CB71D1D
          90FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7676DB5757EC2626EA21
          21E31C1CDA1717D02828C52B2B9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF8888D97676EE3636ED2424E81E1EDE1919D52929C72B2B9EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9191D98D8DED6E6EF26363F14F
          4FEE3636E52121D91616CD1F1FBD1D1D92FF00FFFF00FFFF00FFFF00FFFF00FF
          9797D79E9EEB8787F57D7DF47272F37777E66D6DE15555E34646D93434CE2B2B
          B822228FFF00FFFF00FFFF00FF9C9CD4ACACEA9C9CF79494F68A8AF58B8BE776
          76CA6868C26C6CDA5B5BDE5252D54848CC4141B82F2F91FF00FF9D9DD0B4B4E7
          AEAEF8A7A7F89F9FF79B9BE68181CBFF00FFFF00FF6262B86B6BD25D5DD75151
          CE4747C54141B4323293A9A9C7B8B8EFB5B5F9AFAFF8A8A8E58888CCFF00FFFF
          00FFFF00FFFF00FF5959B06565CB5555CE4B4BC54545BB4343A4FF00FFAAA9C6
          BABAEEB1B1E48F8FCAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5656AD5C5C
          C54F4FC14D4DAAFF00FFFF00FFFF00FFACABC69898CEFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF5050A95858AFFF00FFFF00FF}
        TabOrder = 8
        OnClick = btnApagarClick
      end
      object Panel2: TPanel
        Left = 0
        Top = 113
        Width = 935
        Height = 319
        Align = alBottom
        TabOrder = 9
        object Panel3: TPanel
          Left = 1
          Top = 277
          Width = 933
          Height = 41
          Align = alBottom
          TabOrder = 0
          DesignSize = (
            933
            41)
          object Label7: TLabel
            Left = 684
            Top = 13
            Width = 109
            Height = 17
            Anchors = [akTop, akRight]
            Caption = 'Valor Total Venda'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 700
          end
          object edtTotalValorVenda: TCurrencyEdit
            Left = 801
            Top = 10
            Width = 97
            Height = 23
            Anchors = [akTop, akRight]
            ParentColor = True
            ReadOnly = True
            TabOrder = 0
          end
        end
        object gridItensVenda: TDBGrid
          Left = 1
          Top = 1
          Width = 933
          Height = 276
          Align = alClient
          DataSource = dtmVenda.dsItensVenda
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'produtoId'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nomeProduto'
              Title.Caption = 'PRODUTO'
              Width = 500
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'quantidade'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valorUnitario'
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'valorTotalProduto'
              Width = 130
              Visible = True
            end>
        end
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 462
    Width = 943
    ExplicitTop = 461
    ExplicitWidth = 939
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited btnFechar: TBitBtn
      Left = 807
      ExplicitLeft = 803
    end
  end
  inherited dtsListagem: TDataSource
    Left = 812
    Top = 10
  end
  inherited qryListagem: TFDQuery
    SQL.Strings = (
      'SELECT V.VENDAID, V.DATAVENDA, V.TOTALVENDA, C.NOME  '
      'FROM VENDAS AS V'
      'LEFT JOIN CLIENTES AS C ON C.CLIENTEID = V.CLIENTEID')
    Left = 892
    Top = 10
    object qryListagemVENDAID: TIntegerField
      DisplayLabel = 'NUMERO VENDA'
      DisplayWidth = 16
      FieldName = 'VENDAID'
      Origin = 'VENDAID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryListagemNOME: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'CLIENTE'
      DisplayWidth = 49
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object qryListagemDATAVENDA: TSQLTimeStampField
      DisplayLabel = 'DATA VENDA'
      DisplayWidth = 16
      FieldName = 'DATAVENDA'
      Origin = 'DATAVENDA'
    end
    object qryListagemTOTALVENDA: TFMTBCDField
      DisplayLabel = 'VALOR TOTAL'
      DisplayWidth = 16
      FieldName = 'TOTALVENDA'
      Origin = 'TOTALVENDA'
      currency = True
      Precision = 18
      Size = 2
    end
  end
end
