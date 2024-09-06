inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro categoria'
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
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
