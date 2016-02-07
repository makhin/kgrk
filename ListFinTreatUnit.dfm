object ListFinTreatForm: TListFinTreatForm
  Left = 334
  Top = 230
  Width = 400
  Height = 400
  Caption = 'Платежи от предприятия по договору'
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
  object DBGridEhListFinTreat: TDBGridEh
    Left = 0
    Top = 0
    Width = 392
    Height = 373
    Align = alClient
    DataSource = DataModuleDIM.DataSourceListFinTreat
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyDown = DBGridEhListFinTreatKeyDown
    Columns = <
      item
        EditButtons = <>
        FieldName = 'FinDate'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'PayName'
        Footers = <>
        Width = 217
      end
      item
        EditButtons = <>
        FieldName = 'Finance'
        Footers = <>
      end>
  end
end
