inherited frmBaseList: TfrmBaseList
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmBaseList'
  ClientHeight = 541
  ClientWidth = 904
  OnShow = FormShow
  ExplicitWidth = 920
  ExplicitHeight = 580
  PixelsPerInch = 96
  DesignSize = (
    904
    541)
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 15
    Width = 140
    Height = 26
    Caption = 'Listagem base...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnl_Base: TPanel
    Left = 16
    Top = 56
    Width = 870
    Height = 465
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    Padding.Left = 15
    Padding.Top = 15
    Padding.Right = 15
    Padding.Bottom = 15
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      866
      461)
    object edt_Search: TLabeledEdit
      Left = 15
      Top = 30
      Width = 225
      Height = 27
      EditLabel.Width = 67
      EditLabel.Height = 19
      EditLabel.Caption = 'Pesquisar:'
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
      TextHint = 'E-mail de acesso'
      OnKeyDown = edt_SearchKeyDown
    end
    object DBGrid: TDBGrid
      Left = 15
      Top = 72
      Width = 836
      Height = 374
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = ds_Base
      DrawingStyle = gdsClassic
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Calibri'
      TitleFont.Style = [fsBold]
      OnDrawColumnCell = DBGridDrawColumnCell
    end
    object pnl_BtnActions: TPanel
      Left = 710
      Top = 23
      Width = 141
      Height = 34
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Caption = 'A'#231#245'es '#9660
      Color = 15637837
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      OnMouseLeave = pnl_BtnActionsMouseLeave
      OnMouseMove = pnl_BtnActionsMouseMove
    end
    object pnl_Acoes: TPanel
      Left = 627
      Top = 56
      Width = 223
      Height = 168
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Color = 13333536
      ParentBackground = False
      TabOrder = 3
      Visible = False
      OnMouseLeave = pnl_AcoesMouseLeave
      OnMouseMove = pnl_AcoesMouseMove
      object pnl_BtnVendasOrcamentos: TPanel
        Left = 0
        Top = 69
        Width = 224
        Height = 39
        Cursor = crHandPoint
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '      ( F4 ) - Remover'
        Color = 13333536
        DragCursor = crHandPoint
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        OnMouseLeave = pnl_BtnVendasOrcamentosMouseLeave
        OnMouseMove = pnl_BtnVendasOrcamentosMouseMove
      end
      object Panel3: TPanel
        Left = 0
        Top = 6
        Width = 218
        Height = 19
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '       CONTROLE'
        Font.Charset = ANSI_CHARSET
        Font.Color = 16635329
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnMouseLeave = pnl_AcoesMouseLeave
        OnMouseMove = pnl_AcoesMouseMove
      end
      object pnl_BtnEdit: TPanel
        Left = 0
        Top = 30
        Width = 224
        Height = 39
        Cursor = crHandPoint
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '      ( F3 ) - Editar'
        Color = 13333536
        DragCursor = crHandPoint
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        OnClick = pnl_BtnEditClick
        OnMouseLeave = pnl_BtnEditMouseLeave
        OnMouseMove = pnl_BtnEditMouseMove
      end
    end
  end
  object pnl_BtnaDD: TPanel
    Left = 742
    Top = 10
    Width = 144
    Height = 34
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = '( F2 ) - Adicionar'
    Color = 4561691
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    OnClick = pnl_BtnaDDClick
    OnMouseLeave = MouseLeaveButtonColorGreen
    OnMouseMove = MouseMoveButtonColorGreen
  end
  object fdmt_Base: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 323
    Top = 177
  end
  object ds_Base: TDataSource
    DataSet = fdmt_Base
    Left = 323
    Top = 233
  end
  object TimerHoverBtnActions: TTimer
    Interval = 100
    OnTimer = TimerHoverBtnActionsTimer
    Left = 480
    Top = 320
  end
end
