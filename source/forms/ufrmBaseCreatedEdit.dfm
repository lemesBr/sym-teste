inherited frmBaseCreatedEdit: TfrmBaseCreatedEdit
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'frmBaseCreatedEdit'
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
  object Label2: TLabel
    Left = 338
    Top = 42
    Width = 227
    Height = 15
    Anchors = [akTop]
    Caption = 'Preencha todos os campos corretamente.'
    Font.Charset = ANSI_CHARSET
    Font.Color = 8553090
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = 198
  end
  object lbl_TitleForm: TLabel
    Left = 327
    Top = 10
    Width = 249
    Height = 26
    Alignment = taCenter
    Anchors = [akTop]
    AutoSize = False
    Caption = 'Cadastro de Novo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = 187
  end
  object pnl_Base: TPanel
    Left = 16
    Top = 72
    Width = 870
    Height = 449
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      866
      445)
    object Label3: TLabel
      Left = 30
      Top = 404
      Width = 216
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = '* Campo de preenchimento obrigat'#243'rio'
      Font.Charset = ANSI_CHARSET
      Font.Color = 8553090
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 299
    end
    object pnl_BtnCancell: TPanel
      Left = 605
      Top = 390
      Width = 110
      Height = 41
      Cursor = crHandPoint
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Caption = 'Cancelar'
      Color = 15327706
      Font.Charset = ANSI_CHARSET
      Font.Color = 8018489
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = pnl_BtnCancellClick
    end
    object pnl_BtnSave: TPanel
      Left = 736
      Top = 390
      Width = 110
      Height = 41
      Cursor = crHandPoint
      Anchors = [akRight, akBottom]
      BevelOuter = bvNone
      Caption = 'Salvar'
      Color = 4561691
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
  end
end
