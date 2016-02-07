object ListFinFactForm: TListFinFactForm
  Left = 263
  Top = 223
  Width = 628
  Height = 389
  BorderIcons = [biSystemMenu]
  Caption = 'Список перечислений'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 620
    Height = 41
    Align = alTop
    TabOrder = 0
    object ButtonNew: TButton
      Left = 290
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Новый'
      TabOrder = 3
      OnClick = ButtonNewClick
    end
    object ButtonEdit: TButton
      Left = 372
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Подправить'
      TabOrder = 4
      OnClick = ButtonEditClick
    end
    object ButtonExit: TButton
      Left = 536
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Выход'
      TabOrder = 6
      OnClick = ButtonExitClick
    end
    object ComboBoxFind: TComboBox
      Left = 8
      Top = 8
      Width = 81
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'Сумма'
      Items.Strings = (
        'Сумма'
        'Договор')
    end
    object EditFind: TEdit
      Left = 96
      Top = 8
      Width = 105
      Height = 21
      TabOrder = 1
    end
    object ButtonFind: TButton
      Left = 208
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Найти'
      TabOrder = 2
      OnClick = ButtonFindClick
    end
    object ButtonDel: TButton
      Left = 454
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Удалить'
      TabOrder = 5
      OnClick = ButtonDelClick
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 312
    Width = 620
    Height = 50
    Align = alBottom
    TabOrder = 2
    object DBText1: TDBText
      Left = 16
      Top = 8
      Width = 553
      Height = 17
      DataField = 'Comment'
      DataSource = DataModuleHM.DataSourceListFinFact
    end
    object DBText2: TDBText
      Left = 16
      Top = 24
      Width = 369
      Height = 17
      DataField = 'HospitalName'
      DataSource = DataModuleHM.DataSourceListFinFact
    end
    object DBText3: TDBText
      Left = 504
      Top = 24
      Width = 81
      Height = 17
      DataField = 'DateDeliver'
      DataSource = DataModuleHM.DataSourceListFinFact
    end
    object Label1: TLabel
      Left = 408
      Top = 24
      Width = 76
      Height = 13
      Caption = 'Дата поставки'
    end
  end
  object ListFinFactDBGridEh: TDBGridEh
    Left = 0
    Top = 41
    Width = 620
    Height = 271
    Align = alClient
    DataSource = DataModuleHM.DataSourceListFinFact
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
    Columns = <
      item
        EditButtons = <>
        FieldName = 'FinFactNum'
        Footers = <>
        Width = 33
      end
      item
        EditButtons = <>
        FieldName = 'FinFactDate'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'FinFactTypeName'
        Footers = <>
        Width = 95
      end
      item
        EditButtons = <>
        FieldName = 'Finance'
        Footers = <>
        Width = 79
      end
      item
        EditButtons = <>
        FieldName = 'Contract'
        Footers = <>
        Width = 88
      end
      item
        EditButtons = <>
        FieldName = 'MaxInsurName'
        Footers = <>
        Width = 128
      end
      item
        EditButtons = <>
        FieldName = 'FactoryName'
        Footers = <>
        Width = 110
      end>
  end
end
