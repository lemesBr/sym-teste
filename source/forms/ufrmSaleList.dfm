inherited frmSaleList: TfrmSaleList
  Caption = 'Tela de listagem de vendas.'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  inherited Label1: TLabel
    Width = 189
    Caption = 'Listagem de Vendas...'
    ExplicitWidth = 189
  end
  inherited pnl_Base: TPanel
    object Label2: TLabel [0]
      Left = 326
      Top = 255
      Width = 214
      Height = 26
      Anchors = [akRight]
      Caption = 'Parcelas / Recebimentos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited edt_Search: TLabeledEdit
      EditLabel.ExplicitLeft = 15
      EditLabel.ExplicitTop = 8
      EditLabel.ExplicitWidth = 67
      EditLabel.ExplicitHeight = 19
    end
    inherited DBGrid: TDBGrid
      Height = 177
      Align = alNone
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CODE'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRIPTION'
          Title.Caption = 'Descri'#231#227'o'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NET_TOTAL'
          Title.Caption = 'Total'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FORM_PAYMENT'
          Title.Caption = 'Pagamento'
          Width = 280
          Visible = True
        end>
    end
    object DBGrid1: TDBGrid
      Left = 15
      Top = 287
      Width = 836
      Height = 160
      Anchors = [akLeft, akRight, akBottom]
      DataSource = ds_Bills
      DrawingStyle = gdsClassic
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 4
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Calibri'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'PORTION'
          Title.Caption = 'Parcela'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_DUE'
          Title.Caption = 'Vencimento'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NET_TOTAL'
          Title.Caption = 'Valor'
          Width = 150
          Visible = True
        end>
    end
  end
  inherited fdmt_Base: TFDMemTable
    object fdmt_BaseID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_BaseCODE: TIntegerField
      FieldName = 'CODE'
    end
    object fdmt_BaseDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 255
    end
    object fdmt_BaseNET_TOTAL: TCurrencyField
      FieldName = 'NET_TOTAL'
    end
    object fdmt_BaseFORM_PAYMENT: TStringField
      FieldName = 'FORM_PAYMENT'
      Size = 255
    end
  end
  inherited ds_Base: TDataSource
    OnDataChange = ds_BaseDataChange
  end
  object fdmt_Bills: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 635
    Top = 345
    object fdmt_BillsPORTION: TStringField
      FieldName = 'PORTION'
      Size = 10
    end
    object fdmt_BillsDATE_DUE: TDateField
      FieldName = 'DATE_DUE'
    end
    object fdmt_BillsNET_TOTAL: TCurrencyField
      FieldName = 'NET_TOTAL'
    end
    object fdmt_BillsID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_BillsSALE_ID: TStringField
      FieldName = 'SALE_ID'
      Size = 32
    end
  end
  object ds_Bills: TDataSource
    DataSet = fdmt_Bills
    Left = 635
    Top = 401
  end
end
