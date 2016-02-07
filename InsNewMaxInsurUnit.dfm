object MaxInsurForm: TMaxInsurForm
  Left = 338
  Top = 220
  Width = 401
  Height = 274
  BorderIcons = [biSystemMenu]
  Caption = 'Договор страхования'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 50
    Height = 13
    Caption = 'Название'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 34
    Height = 13
    Caption = 'Сумма'
  end
  object Label3: TLabel
    Left = 8
    Top = 144
    Width = 61
    Height = 13
    Caption = '№ договора'
  end
  object Label4: TLabel
    Left = 8
    Top = 176
    Width = 69
    Height = 13
    Caption = 'Вид договора'
  end
  object Label5: TLabel
    Left = 232
    Top = 48
    Width = 39
    Height = 13
    Caption = 'Взносы'
  end
  object Label6: TLabel
    Left = 8
    Top = 80
    Width = 41
    Height = 13
    Caption = 'Лимиты'
  end
  object Label7: TLabel
    Left = 8
    Top = 112
    Width = 35
    Height = 13
    Caption = 'Общий'
  end
  object Label8: TLabel
    Left = 160
    Top = 110
    Width = 24
    Height = 13
    Caption = 'Мед.'
  end
  object Label9: TLabel
    Left = 272
    Top = 110
    Width = 29
    Height = 13
    Caption = 'Обсл.'
  end
  object BitBtnSave: TBitBtn
    Left = 96
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Сохр.'
    Default = True
    TabOrder = 11
    OnClick = BitBtnSaveClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtnCancel: TBitBtn
    Left = 248
    Top = 208
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Отмена'
    TabOrder = 12
    OnClick = BitBtnCancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object EditMaxInsurName: TEdit
    Left = 80
    Top = 8
    Width = 297
    Height = 21
    TabOrder = 0
  end
  object CurrencyEditMaxInsurMoney: TCurrencyEdit
    Left = 80
    Top = 40
    Width = 97
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 1
  end
  object EditComment: TEdit
    Left = 80
    Top = 136
    Width = 297
    Height = 21
    TabOrder = 8
  end
  object ComboBoxLic: TComboBox
    Left = 80
    Top = 168
    Width = 201
    Height = 21
    ItemHeight = 13
    TabOrder = 9
  end
  object ButtonAdd: TButton
    Left = 304
    Top = 172
    Width = 75
    Height = 17
    Caption = 'Добавить'
    TabOrder = 10
    OnClick = ButtonAddClick
  end
  object CurrencyEditMaxInsurPayment: TCurrencyEdit
    Left = 280
    Top = 40
    Width = 97
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 2
  end
  object ComboBoxTreat: TComboBox
    Left = 80
    Top = 72
    Width = 185
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    OnChange = ComboBoxTreatChange
  end
  object ButtonSaveLimit: TButton
    Left = 302
    Top = 72
    Width = 75
    Height = 17
    Caption = 'Сохранить'
    TabOrder = 4
    OnClick = ButtonSaveLimitClick
  end
  object CurrencyEditLimit: TCurrencyEdit
    Left = 80
    Top = 104
    Width = 73
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 5
  end
  object CurrencyEditMedLim: TCurrencyEdit
    Left = 192
    Top = 104
    Width = 73
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 6
  end
  object CurrencyEditServLim: TCurrencyEdit
    Left = 304
    Top = 103
    Width = 73
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 7
  end
end
