object BranchForm: TBranchForm
  Left = 304
  Top = 258
  Width = 445
  Height = 154
  Caption = 'Отделение'
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
    Left = 8
    Top = 40
    Width = 73
    Height = 26
    Caption = 'Койко-день'#13#10'Амбулаторное'
  end
  object Label1: TLabel
    Left = 224
    Top = 40
    Width = 72
    Height = 26
    Caption = 'Койко-день'#13#10'Стационарное'
  end
  object BitBtnSave: TBitBtn
    Left = 104
    Top = 80
    Width = 89
    Height = 33
    Caption = 'Сохранить'
    TabOrder = 3
    OnClick = BitBtnSaveClick
    Kind = bkOK
  end
  object BitBtnCancel: TBitBtn
    Left = 240
    Top = 80
    Width = 89
    Height = 33
    Caption = 'Отменить'
    TabOrder = 4
    OnClick = BitBtnCancelClick
    Kind = bkCancel
  end
  object CurrencyEditBedDay2: TCurrencyEdit
    Left = 304
    Top = 40
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 2
  end
  object MemoBranchName: TEdit
    Left = 8
    Top = 8
    Width = 417
    Height = 21
    TabOrder = 0
    OnEnter = MemoBranchNameEnter
  end
  object CurrencyEditBedDay1: TCurrencyEdit
    Left = 88
    Top = 40
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 1
  end
end
