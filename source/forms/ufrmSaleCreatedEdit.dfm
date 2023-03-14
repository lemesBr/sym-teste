inherited frmSaleCreatedEdit: TfrmSaleCreatedEdit
  Caption = 'Cadastro ou Altera'#231#227'o de Vendas.'
  ClientWidth = 1022
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1038
  PixelsPerInch = 96
  TextHeight = 15
  inherited Label2: TLabel
    Left = 397
    ExplicitLeft = 397
  end
  inherited lbl_TitleForm: TLabel
    Left = 386
    ExplicitLeft = 386
  end
  inherited pnl_Base: TPanel
    Width = 988
    ExplicitWidth = 988
    object Label7: TLabel [1]
      Left = 515
      Top = 53
      Width = 78
      Height = 19
      Caption = 'Tipo Pessoa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    inherited pnl_BtnCancell: TPanel
      Left = 723
      TabOrder = 3
      ExplicitLeft = 723
    end
    inherited pnl_BtnSave: TPanel
      Left = 854
      TabOrder = 4
      OnClick = pnl_BtnSaveClick
      ExplicitLeft = 854
    end
    object Panel1: TPanel
      Left = 15
      Top = 5
      Width = 950
      Height = 41
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Caption = 'Dados gerais'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object Panel2: TPanel
        Left = 0
        Top = 40
        Width = 950
        Height = 1
        Align = alBottom
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
      end
    end
    object lbe_Description: TLabeledEdit
      Left = 15
      Top = 76
      Width = 328
      Height = 27
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      EditLabel.Width = 143
      EditLabel.Height = 19
      EditLabel.Caption = '* Descricao da venda:'
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Calibri'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object cbx_Payment: TComboBox
      Left = 515
      Top = 76
      Width = 262
      Height = 27
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = #192' Vista'
      OnChange = cbx_PaymentChange
      Items.Strings = (
        #192' Vista'
        '50% de Entrada + Restante em 30/60'
        '30/60 Sem Entrada'
        '15 dias')
    end
    object lbe_SaleValue: TLabeledEdit
      Left = 359
      Top = 76
      Width = 138
      Height = 27
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      EditLabel.Width = 112
      EditLabel.Height = 19
      EditLabel.Caption = '* Valor de venda:'
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Calibri'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = ''
    end
    object pnl_BtnCalc: TPanel
      Left = 814
      Top = 68
      Width = 110
      Height = 41
      Cursor = crHandPoint
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Caption = 'Calcular'
      Color = 16294036
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 6
      OnClick = pnl_BtnCalcClick
    end
    object DBGrid: TDBGrid
      Left = 15
      Top = 128
      Width = 762
      Height = 217
      DataSource = ds_Bills
      DrawingStyle = gdsClassic
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 7
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
  object ds_Bills: TDataSource
    DataSet = fdmt_Bills
    Left = 339
    Top = 273
  end
  object fdmt_Bills: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 339
    Top = 217
    object fdmt_BillsPORTION: TStringField
      FieldName = 'PORTION'
      Size = 10
    end
    object fdmt_BillsDATE_DUE: TDateField
      FieldName = 'DATE_DUE'
    end
    object fdmt_BillsID: TStringField
      FieldName = 'ID'
      Size = 32
    end
    object fdmt_BillsSALE_ID: TStringField
      FieldName = 'SALE_ID'
      Size = 32
    end
    object fdmt_BillsNET_TOTAL: TCurrencyField
      FieldName = 'NET_TOTAL'
    end
  end
end
