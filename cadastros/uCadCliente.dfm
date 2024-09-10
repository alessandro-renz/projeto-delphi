inherited frmCadCliente: TfrmCadCliente
  Caption = 'frmCadCliente'
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    ExplicitWidth = 951
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Height = 368
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
        Left = 376
        Top = 92
        Width = 103
        Height = 23
        EditMask = '99999-000;1;_'
        MaxLength = 9
        TabOrder = 2
        Text = '     -   '
      end
      object edtEstado: TLabeledEdit
        Left = 16
        Top = 204
        Width = 121
        Height = 23
        EditLabel.Width = 35
        EditLabel.Height = 15
        EditLabel.Caption = 'Estado'
        MaxLength = 2
        TabOrder = 3
        Text = ''
      end
      object edtEndereco: TLabeledEdit
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
        Left = 528
        Top = 92
        Width = 201
        Height = 23
        EditLabel.Width = 37
        EditLabel.Height = 15
        EditLabel.Caption = 'Cidade'
        TabOrder = 5
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
        Width = 121
        Height = 23
        EditMask = '(99)99999-9999;1;_'
        MaxLength = 14
        TabOrder = 7
        Text = '(  )     -    '
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
    ExplicitTop = 463
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
end
