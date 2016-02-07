object HospitalForm: THospitalForm
  Left = 316
  Top = 304
  Width = 445
  Height = 170
  BorderIcons = [biSystemMenu]
  Caption = 'Медицинские учереждения'
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
  object MemoHospitalName: TEdit
    Left = 8
    Top = 8
    Width = 417
    Height = 21
    TabOrder = 0
    OnEnter = MemoHospitalNameEnter
  end
end
