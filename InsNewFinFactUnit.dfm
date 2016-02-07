object InsNewFinFactForm: TInsNewFinFactForm
  Left = 265
  Top = 217
  Width = 509
  Height = 239
  Caption = 'Перечисление'
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
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 49
    Height = 13
    Caption = 'Проплата'
  end
  object Label2: TLabel
    Left = 312
    Top = 16
    Width = 42
    Height = 13
    Caption = '№ счета'
  end
  object Label3: TLabel
    Left = 16
    Top = 48
    Width = 19
    Height = 13
    Caption = 'Тип'
  end
  object Label4: TLabel
    Left = 312
    Top = 48
    Width = 34
    Height = 13
    Caption = 'Сумма'
  end
  object Label5: TLabel
    Left = 16
    Top = 80
    Width = 26
    Height = 13
    Caption = 'Кому'
  end
  object Label6: TLabel
    Left = 312
    Top = 80
    Width = 49
    Height = 13
    Caption = 'Поставка'
  end
  object Label7: TLabel
    Left = 16
    Top = 112
    Width = 44
    Height = 13
    Caption = 'Договор'
  end
  object Label8: TLabel
    Left = 232
    Top = 112
    Width = 67
    Height = 13
    Caption = 'Предприятие'
  end
  object DateEditFinFactDate: TDateEdit
    Left = 80
    Top = 8
    Width = 145
    Height = 21
    NumGlyphs = 2
    TabOrder = 0
  end
  object EditContract: TEdit
    Left = 368
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object ComboBoxType: TComboBox
    Left = 80
    Top = 40
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object CurrencyEditFinance: TCurrencyEdit
    Left = 368
    Top = 40
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 5
  end
  object ComboBoxHospital: TComboBox
    Left = 80
    Top = 72
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 6
  end
  object DateEditDeliverDate: TDateEdit
    Left = 368
    Top = 72
    Width = 121
    Height = 21
    NumGlyphs = 2
    TabOrder = 9
  end
  object EditComment: TEdit
    Left = 16
    Top = 136
    Width = 473
    Height = 21
    TabOrder = 11
  end
  object BitBtnSave: TBitBtn
    Left = 104
    Top = 168
    Width = 89
    Height = 33
    Caption = 'Сохранить'
    TabOrder = 12
    OnClick = BitBtnSaveClick
    Kind = bkOK
  end
  object BitBtnCancel: TBitBtn
    Left = 288
    Top = 168
    Width = 89
    Height = 33
    Caption = 'Отменить'
    TabOrder = 13
    OnClick = BitBtnCancelClick
    Kind = bkCancel
  end
  object ButtonEditType: TButton
    Left = 230
    Top = 34
    Width = 75
    Height = 16
    Caption = 'Редакт.'
    TabOrder = 3
    OnClick = ButtonEditTypeClick
  end
  object ButtonInsType: TButton
    Left = 230
    Top = 50
    Width = 75
    Height = 16
    Caption = 'Добавить'
    TabOrder = 4
    OnClick = ButtonInsTypeClick
  end
  object ButtonEditRec: TButton
    Left = 230
    Top = 69
    Width = 75
    Height = 16
    Caption = 'Редакт.'
    TabOrder = 7
    OnClick = ButtonEditRecClick
  end
  object ButtonInsRec: TButton
    Left = 230
    Top = 85
    Width = 75
    Height = 16
    Caption = 'Добавить'
    TabOrder = 8
    OnClick = ButtonInsRecClick
  end
  object ComboBoxMaxInsur: TComboBox
    Left = 80
    Top = 104
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 10
  end
  object ComboBoxFactory: TComboBox
    Left = 312
    Top = 104
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 14
  end
end
