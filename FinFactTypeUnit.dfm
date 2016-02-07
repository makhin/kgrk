object FinFactTypeForm: TFinFactTypeForm
  Left = 309
  Top = 288
  Width = 445
  Height = 170
  Caption = 'Тип перечисления'
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
  object MemoFinFactTypeName: TMemo
    Left = 8
    Top = 8
    Width = 417
    Height = 49
    TabOrder = 0
    OnEnter = MemoFinFactTypeNameEnter
  end
  object BitBtnSave: TBitBtn
    Left = 104
    Top = 96
    Width = 89
    Height = 33
    Caption = 'Сохранить'
    TabOrder = 1
    OnClick = BitBtnSaveClick
    Kind = bkOK
  end
  object BitBtnCancel: TBitBtn
    Left = 240
    Top = 96
    Width = 89
    Height = 33
    Caption = 'Отменить'
    TabOrder = 2
    OnClick = BitBtnCancelClick
    Kind = bkCancel
  end
end
