inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de clientes'
  OnDestroy = FormDestroy
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      inherited Panel1: TPanel
        ExplicitWidth = 943
      end
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'CLIENTEID'
            Title.Caption = 'CODIGO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CIDADE'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ESTADO'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TELEFONE'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATANASCIMENTO'
            Title.Caption = 'DATA NASCIMENTO'
            Width = 120
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      object Label1: TLabel
        Left = 376
        Top = 74
        Width = 21
        Height = 15
        Caption = 'CEP'
      end
      object label2: TLabel
        Left = 16
        Top = 242
        Width = 44
        Height = 15
        Caption = 'Telefone'
      end
      object Label3: TLabel
        Left = 16
        Top = 297
        Width = 91
        Height = 15
        Caption = 'Data Nascimento'
      end
      object edtCodigo: TLabeledEdit
        Tag = 1
        Left = 16
        Top = 40
        Width = 121
        Height = 23
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo'
        NumbersOnly = True
        TabOrder = 0
        Text = ''
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 16
        Top = 92
        Width = 319
        Height = 23
        EditLabel.Width = 33
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome'
        TabOrder = 1
        Text = ''
      end
      object edtCep: TMaskEdit
        Tag = 2
        Left = 376
        Top = 92
        Width = 99
        Height = 23
        EditMask = '99999-999;0;_'
        MaxLength = 9
        TabOrder = 2
        Text = ''
        OnChange = edtCepChange
      end
      object edtEstado: TLabeledEdit
        Tag = 2
        Left = 16
        Top = 204
        Width = 121
        Height = 23
        EditLabel.Width = 35
        EditLabel.Height = 15
        EditLabel.Caption = 'Estado'
        MaxLength = 2
        TabOrder = 5
        Text = ''
      end
      object edtEndereco: TLabeledEdit
        Tag = 2
        Left = 16
        Top = 148
        Width = 713
        Height = 23
        EditLabel.Width = 49
        EditLabel.Height = 15
        EditLabel.Caption = 'Endere'#231'o'
        TabOrder = 4
        Text = ''
      end
      object edtCidade: TLabeledEdit
        Tag = 2
        Left = 528
        Top = 92
        Width = 201
        Height = 23
        EditLabel.Width = 37
        EditLabel.Height = 15
        EditLabel.Caption = 'Cidade'
        TabOrder = 3
        Text = ''
      end
      object edtBairro: TLabeledEdit
        Left = 184
        Top = 204
        Width = 545
        Height = 23
        EditLabel.Width = 31
        EditLabel.Height = 15
        EditLabel.Caption = 'Bairro'
        TabOrder = 6
        Text = ''
      end
      object edtTelefone: TMaskEdit
        Left = 16
        Top = 260
        Width = 117
        Height = 23
        EditMask = '(99)99999-9999;0;_'
        MaxLength = 14
        TabOrder = 7
        Text = ''
      end
      object edtEmail: TLabeledEdit
        Left = 184
        Top = 260
        Width = 545
        Height = 23
        EditLabel.Width = 34
        EditLabel.Height = 15
        EditLabel.Caption = 'E-mail'
        TabOrder = 8
        Text = ''
      end
      object edtNascimento: TDateEdit
        Left = 16
        Top = 316
        Width = 121
        Height = 23
        NumGlyphs = 2
        TabOrder = 9
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited btnFechar: TBitBtn
      Left = 827
      ExplicitLeft = 823
    end
  end
  inherited qryListagem: TFDQuery
    SQL.Strings = (
      
        'Select CLIENTEID, NOME, CIDADE, ESTADO, TELEFONE, DATANASCIMENTO' +
        ' from clientes;')
    object qryListagemCLIENTEID: TIntegerField
      FieldName = 'CLIENTEID'
      Origin = 'CLIENTEID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryListagemNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 255
    end
    object qryListagemCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Required = True
      Size = 100
    end
    object qryListagemESTADO: TStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      Required = True
      FixedChar = True
      Size = 2
    end
    object qryListagemTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Size = 11
    end
    object qryListagemDATANASCIMENTO: TDateField
      FieldName = 'DATANASCIMENTO'
      Origin = 'DATANASCIMENTO'
    end
  end
end
