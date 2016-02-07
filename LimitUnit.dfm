object LimitForm: TLimitForm
  Left = 304
  Top = 258
  Width = 445
  Height = 154
  Caption = 'Лимит'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 224
    Top = 48
    Width = 33
    Height = 13
    Caption = 'Лимит'
  end
  object BitBtnSave: TBitBtn
    Left = 104
    Top = 80
    Width = 89
    Height = 33
    Caption = 'Сохранить'
    TabOrder = 2
    OnClick = BitBtnSaveClick
    Kind = bkOK
  end
  object BitBtnCancel: TBitBtn
    Left = 240
    Top = 80
    Width = 89
    Height = 33
    Caption = 'Отменить'
    TabOrder = 3
    OnClick = BitBtnCancelClick
    Kind = bkCancel
  end
  object CurrencyEditInsurLimit: TCurrencyEdit
    Left = 304
    Top = 40
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 1
  end
  object MemoInsurLimitName: TEdit
    Left = 8
    Top = 8
    Width = 417
    Height = 21
    TabOrder = 0
    OnEnter = MemoInsurLimitNameEnter
  end
end
