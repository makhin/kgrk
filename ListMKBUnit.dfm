object ListMKBDiagForm: TListMKBDiagForm
  Left = 273
  Top = 252
  Width = 570
  Height = 280
  BorderIcons = [biSystemMenu]
  Caption = 'Поиск диазноза по названию'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 562
    Height = 41
    Align = alTop
    TabOrder = 0
    object MKBDiagNameEdit: TEdit
      Left = 16
      Top = 8
      Width = 361
      Height = 21
      TabOrder = 0
      OnEnter = MKBDiagNameEditEnter
      OnKeyDown = MKBDiagNameEditKeyDown
    end
    object ButtonFind: TButton
      Left = 392
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Найти'
      TabOrder = 1
      OnClick = ButtonFindClick
    end
    object ButtonExit: TButton
      Left = 480
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Вернуть'
      TabOrder = 2
      OnClick = ButtonExitClick
    end
  end
  object DBGridEhDiag: TDBGridEh
    Left = 0
    Top = 41
    Width = 562
    Height = 212
    Align = alClient
    DataSource = DataModuleHM.DataSourceListMKBDiag
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = ButtonExitClick
    OnKeyDown = DBGridEhDiagKeyDown
    Columns = <
      item
        EditButtons = <>
        FieldName = 'MKBDiagNum'
        Footers = <>
        Width = 48
      end
      item
        EditButtons = <>
        FieldName = 'MKBDiagName'
        Footers = <>
        Width = 465
      end>
  end
end
