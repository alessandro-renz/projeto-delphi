object dtmVenda: TdtmVenda
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object qryCliente: TFDQuery
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'SELECT CLIENTEID, NOME FROM CLIENTES')
    Left = 96
    Top = 88
    object qryClienteCLIENTEID: TIntegerField
      FieldName = 'CLIENTEID'
      Origin = 'CLIENTEID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryClienteNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 255
    end
  end
  object qryProduto: TFDQuery
    Connection = dtmConexao.FDConnection
    SQL.Strings = (
      'SELECT PRODUTOID, NOME, VALOR FROM PRODUTOS')
    Left = 192
    Top = 88
    object qryProdutoPRODUTOID: TIntegerField
      FieldName = 'PRODUTOID'
      Origin = 'PRODUTOID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryProdutoNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 255
    end
    object qryProdutoVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Precision = 18
      Size = 5
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 88
    object cdsItensVendaprodutoId: TIntegerField
      DisplayLabel = 'C'#211'DIGO'
      FieldName = 'produtoId'
    end
    object cdsItensVendanomeProduto: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'nomeProduto'
      Size = 255
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'QUANTIDADE'
      FieldName = 'quantidade'
    end
    object cdsItensVendavalorUnitario: TFloatField
      DisplayLabel = 'VALOR UNIT'#193'RIO'
      FieldName = 'valorUnitario'
      currency = True
    end
    object cdsItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'VALOR TOTAL'
      FieldName = 'valorTotalProduto'
      currency = True
    end
  end
  object dsCliente: TDataSource
    DataSet = qryCliente
    Left = 96
    Top = 160
  end
  object dsProduto: TDataSource
    DataSet = qryProduto
    Left = 192
    Top = 160
  end
  object dsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 296
    Top = 160
  end
end
