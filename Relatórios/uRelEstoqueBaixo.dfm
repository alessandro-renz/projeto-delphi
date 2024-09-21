inherited frmRelEstoqueBaixo: TfrmRelEstoqueBaixo
  Caption = 'Relatorio estoque baixo'
  TextHeight = 15
  inherited relMain: TRLReport
    inherited RLBand1: TRLBand
      inherited lblTitle: TRLLabel
        Left = 243
        Top = 11
        Width = 222
        Caption = 'PRODUTOS COM ESTOQUE BAIXO'
        Font.Style = [fsBold]
        ExplicitLeft = 243
        ExplicitTop = 11
        ExplicitWidth = 222
      end
    end
    inherited RLBand2: TRLBand
      inherited coluna1: TRLLabel
        Width = 55
        Height = 16
        Caption = 'CODIGO'
        ExplicitWidth = 55
        ExplicitHeight = 16
      end
      inherited coluna2: TRLLabel
        Left = 137
        Width = 67
        Height = 16
        Caption = 'PRODUTO'
        ExplicitLeft = 137
        ExplicitWidth = 67
        ExplicitHeight = 16
      end
      inherited coluna3: TRLLabel
        Width = 87
        Height = 16
        Caption = 'QUANTIDADE'
        ExplicitWidth = 87
        ExplicitHeight = 16
      end
      inherited RLDraw1: TRLDraw
        Top = 34
      end
      object RLLabel1: TRLLabel
        Left = 493
        Top = 17
        Width = 115
        Height = 16
        Caption = 'ULTIMA ENTRADA'
      end
    end
    inherited RLBand3: TRLBand
      inherited dbField2: TRLDBText
        Left = 137
        ExplicitLeft = 137
      end
      inherited dbField3: TRLDBText
        Width = 87
        DataField = 'QUANTIDADE'
        ExplicitWidth = 87
      end
      object RLDBText1: TRLDBText
        Left = 493
        Top = 14
        Width = 118
        Height = 16
        DataField = 'ULTIMA_ENTRADA'
        DataSource = dsRelatorio
        Text = ''
      end
    end
  end
  inherited qryRelatorio: TFDQuery
    SQL.Strings = (
      
        'SELECT E.QUANTIDADE, E.quantidade_minima, E.ultima_entrada, P.pr' +
        'odutoid ,P.nome FROM ESTOQUE AS E'
      'LEFT JOIN PRODUTOS AS P ON P.produtoid = E.produtoid'
      'WHERE E.QUANTIDADE <= E.QUANTIDADE_MINIMA;')
    object qryRelatorioQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Required = True
      Precision = 18
      Size = 2
    end
    object qryRelatorioQUANTIDADE_MINIMA: TFMTBCDField
      FieldName = 'QUANTIDADE_MINIMA'
      Origin = 'QUANTIDADE_MINIMA'
      Precision = 18
      Size = 2
    end
    object qryRelatorioULTIMA_ENTRADA: TSQLTimeStampField
      FieldName = 'ULTIMA_ENTRADA'
      Origin = 'ULTIMA_ENTRADA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qryRelatorioPRODUTOID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'PRODUTOID'
      Origin = 'PRODUTOID'
      ProviderFlags = []
      ReadOnly = True
    end
    object qryRelatorioNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
  end
end
