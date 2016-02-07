object ListMaxInsurForm: TListMaxInsurForm
  Left = 167
  Top = 134
  Width = 780
  Height = 480
  BorderIcons = [biSystemMenu]
  Caption = 'Договора'
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
    Width = 772
    Height = 41
    Align = alTop
    TabOrder = 0
    object ButtonAdd: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Новый'
      TabOrder = 0
      OnClick = ButtonAddClick
    end
    object ButtonEdit: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Подправить'
      TabOrder = 1
      OnClick = ButtonEditClick
    end
    object ButtonDel: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Удалить'
      TabOrder = 2
      OnClick = ButtonDelClick
    end
    object ButtonPay: TButton
      Left = 248
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Общий взнос'
      TabOrder = 3
      OnClick = ButtonPayClick
    end
    object ButtonFin: TButton
      Left = 328
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Финансы'
      TabOrder = 4
      OnClick = ButtonFinClick
    end
  end
  object DBGridEhListTreat: TDBGridEh
    Left = 0
    Top = 41
    Width = 772
    Height = 412
    Align = alClient
    DataSource = DataModuleHM.DataSourceMaxInsur
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
        FieldName = 'MaxInsurNum'
        Footers = <>
        Width = 25
      end
      item
        EditButtons = <>
        FieldName = 'MaxInsurName'
        Footers = <>
        Width = 156
      end
      item
        EditButtons = <>
        FieldName = 'Comment'
        Footers = <>
        Width = 236
      end
      item
        EditButtons = <>
        FieldName = 'Licname'
        Footers = <>
        Width = 143
      end
      item
        EditButtons = <>
        FieldName = 'MaxInsurMoney'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 's'
        Footers = <>
      end>
  end
end
