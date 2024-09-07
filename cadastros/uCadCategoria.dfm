inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro categoria'
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'CATEGORIAID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      object lblTitle: TLabel
        Left = 24
        Top = 16
        Width = 108
        Height = 20
        Caption = 'MANUTEN'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object edtCodigo: TLabeledEdit
        Tag = 1
        Left = 24
        Top = 80
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
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 24
        Top = 136
        Width = 397
        Height = 23
        EditLabel.Width = 51
        EditLabel.Height = 15
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 59
        NumbersOnly = True
        TabOrder = 1
        Text = ''
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited qryListagem: TFDQuery
    SQL.Strings = (
      'SELECT categoriaId, descricao FROM CATEGORIAS;')
    object qryListagemCATEGORIAID: TIntegerField
      DisplayLabel = 'C'#211'DIGO'
      FieldName = 'CATEGORIAID'
      Origin = 'CATEGORIAID'
      Required = True
    end
    object qryListagemDESCRICAO: TStringField
      DisplayLabel = 'DESCRI'#199#195'O'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 60
    end
  end
end
