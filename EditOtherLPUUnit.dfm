object EditOtherLPUForm: TEditOtherLPUForm
  Left = 270
  Top = 167
  Width = 530
  Height = 360
  BorderIcons = [biSystemMenu]
  Caption = 'Страховые случаи'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 522
    Height = 57
    Align = alTop
    TabOrder = 0
    object LabelClientNum: TLabel
      Left = 8
      Top = 8
      Width = 74
      Height = 13
      Caption = 'LabelClientNum'
    end
    object LabelClientName: TLabel
      Left = 104
      Top = 8
      Width = 80
      Height = 13
      Caption = 'LabelClientName'
    end
    object DBTextComment: TDBText
      Left = 8
      Top = 32
      Width = 433
      Height = 25
      DataField = 'Comment'
      DataSource = DataModuleDMK.DataSourceListInsurCase
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 292
    Width = 522
    Height = 41
    Align = alBottom
    TabOrder = 2
    object ButtonEdit: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Редакт'
      TabOrder = 0
      OnClick = ButtonEditClick
    end
    object ButtonIns: TButton
      Left = 155
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Новый'
      TabOrder = 1
      OnClick = ButtonInsClick
    end
    object ButtonExit: TButton
      Left = 432
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Выход'
      TabOrder = 3
      OnClick = ButtonExitClick
    end
    object ButtonDel: TButton
      Left = 293
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Удалить'
      TabOrder = 2
      OnClick = ButtonDelClick
    end
  end
  object DBGridEhListOtherLPUCase: TDBGridEh
    Left = 0
    Top = 57
    Width = 522
    Height = 235
    Align = alClient
    DataSource = DataModuleDMK.DataSourceListInsurCase
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
        FieldName = 'InsurCaseNum'
        Footers = <>
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'BeginDate'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'EndDate'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'TreatName'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'DiagName'
        Footers = <>
        Width = 162
      end>
  end
end
