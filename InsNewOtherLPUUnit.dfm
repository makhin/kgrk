object InsNewOtherLPUForm: TInsNewOtherLPUForm
  Left = 245
  Top = 165
  Width = 494
  Height = 479
  BorderIcons = [biSystemMenu]
  Caption = 'Другие ЛПУ'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 168
    Top = 211
    Width = 35
    Height = 13
    Caption = 'С даты'
  end
  object Label4: TLabel
    Left = 312
    Top = 211
    Width = 49
    Height = 13
    Caption = 'Протокол'
  end
  object Label11: TLabel
    Left = 8
    Top = 211
    Width = 62
    Height = 13
    Caption = 'Больничный'
  end
  object Label2: TLabel
    Left = 8
    Top = 80
    Width = 43
    Height = 13
    Caption = 'Лечение'
  end
  object Label7: TLabel
    Left = 8
    Top = 48
    Width = 48
    Height = 13
    Caption = 'Тип диаг.'
  end
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 69
    Height = 13
    Caption = 'Код диагноза'
  end
  object Label13: TLabel
    Left = 8
    Top = 144
    Width = 24
    Height = 13
    Caption = 'Врач'
  end
  object Label12: TLabel
    Left = 8
    Top = 112
    Width = 24
    Height = 13
    Caption = 'ЛПУ'
  end
  object Label5: TLabel
    Left = 312
    Top = 243
    Width = 59
    Height = 13
    Caption = 'Документы'
  end
  object Label6: TLabel
    Left = 8
    Top = 243
    Width = 43
    Height = 13
    Caption = 'Процент'
  end
  object Label8: TLabel
    Left = 168
    Top = 243
    Width = 39
    Height = 13
    Caption = 'По дату'
  end
  object Label10: TLabel
    Left = 8
    Top = 275
    Width = 18
    Height = 13
    Caption = 'Акт'
  end
  object Label9: TLabel
    Left = 168
    Top = 275
    Width = 34
    Height = 13
    Caption = 'Сумма'
  end
  object Label14: TLabel
    Left = 312
    Top = 275
    Width = 49
    Height = 13
    Caption = 'Коммент.'
  end
  object Label15: TLabel
    Left = 7
    Top = 178
    Width = 55
    Height = 13
    Caption = 'Отделение'
  end
  object DateEditBegin: TDateEdit
    Left = 208
    Top = 203
    Width = 97
    Height = 21
    NumGlyphs = 2
    TabOrder = 17
  end
  object DateEditEnd: TDateEdit
    Left = 376
    Top = 203
    Width = 97
    Height = 21
    NumGlyphs = 2
    TabOrder = 18
  end
  object PanelMid: TPanel
    Left = 0
    Top = 300
    Width = 486
    Height = 152
    Align = alBottom
    TabOrder = 25
    object DBGridEhOrder: TDBGridEh
      Left = 1
      Top = 1
      Width = 240
      Height = 150
      Align = alLeft
      DataSource = DataModuleDMK.DataSourceListFinOther_LPU
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      FooterRowCount = 1
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          EditButtons = <>
          FieldName = 'FinNum'
          Footers = <>
        end
        item
          EditButtons = <>
          FieldName = 'FinDate'
          Footer.Value = 'Итого'
          Footer.ValueType = fvtStaticText
          Footers = <>
        end
        item
          EditButtons = <>
          FieldName = 'Finance'
          Footer.FieldName = 'Finance'
          Footer.ValueType = fvtSum
          Footers = <>
        end>
    end
    object BitBtnSave: TBitBtn
      Left = 264
      Top = 104
      Width = 89
      Height = 33
      Caption = 'Сохранить'
      Default = True
      TabOrder = 3
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
      Left = 376
      Top = 104
      Width = 89
      Height = 33
      Caption = 'Отменить'
      TabOrder = 4
      OnClick = BitBtnCancelClick
      Kind = bkCancel
    end
    object ButtonNewOrder: TButton
      Left = 264
      Top = 8
      Width = 65
      Height = 25
      Caption = 'Новый'
      TabOrder = 1
      OnClick = ButtonNewOrderClick
    end
    object ButtonUnOrder: TButton
      Left = 264
      Top = 40
      Width = 65
      Height = 25
      Caption = 'Откат'
      TabOrder = 2
      OnClick = ButtonUnOrderClick
    end
  end
  object EditSickList: TEdit
    Left = 80
    Top = 203
    Width = 81
    Height = 21
    TabOrder = 16
  end
  object ComboBoxDiag: TComboBox
    Left = 80
    Top = 40
    Width = 313
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object ComboBoxTreat: TComboBox
    Left = 80
    Top = 72
    Width = 195
    Height = 21
    ItemHeight = 13
    TabOrder = 5
  end
  object ButtonInsDiag: TButton
    Left = 398
    Top = 53
    Width = 75
    Height = 16
    Caption = 'Добавить'
    TabOrder = 4
    OnClick = ButtonInsDiagClick
  end
  object MaskEditMKBDiag: TMaskEdit
    Left = 80
    Top = 8
    Width = 57
    Height = 21
    CharCase = ecUpperCase
    EditMask = '>C,99,99;1;_'
    MaxLength = 7
    TabOrder = 0
    Text = ' ,  ,  '
    OnChange = MaskEditMKBDiagChange
    OnEnter = MaskEditMKBDiagEnter
    OnKeyDown = MaskEditMKBDiagKeyDown
  end
  object ComboBoxIll: TComboBox
    Left = 280
    Top = 72
    Width = 195
    Height = 21
    ItemHeight = 13
    TabOrder = 6
  end
  object ComboBoxHospital: TComboBox
    Left = 80
    Top = 104
    Width = 313
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    OnChange = ComboBoxHospitalChange
  end
  object ComboBoxDoctor: TComboBox
    Left = 80
    Top = 136
    Width = 313
    Height = 21
    ItemHeight = 13
    TabOrder = 10
  end
  object ButtonInsHospital: TButton
    Left = 399
    Top = 113
    Width = 75
    Height = 16
    Caption = 'Добавить'
    TabOrder = 9
    OnClick = ButtonInsHospitalClick
  end
  object ButtonInsDoctor: TButton
    Left = 400
    Top = 147
    Width = 75
    Height = 16
    Caption = 'Добавить'
    TabOrder = 12
    OnClick = ButtonInsDoctorClick
  end
  object MemoMKBDiagName: TMemo
    Left = 144
    Top = 0
    Width = 329
    Height = 33
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ButtonEditDiag: TButton
    Left = 398
    Top = 37
    Width = 75
    Height = 16
    Caption = 'Редакт.'
    TabOrder = 3
    OnClick = ButtonEditDiagClick
  end
  object ButtonEditHospital: TButton
    Left = 399
    Top = 97
    Width = 75
    Height = 16
    Caption = 'Редакт.'
    TabOrder = 8
    OnClick = ButtonEditHospitalClick
  end
  object ButtonEditDoctor: TButton
    Left = 400
    Top = 131
    Width = 75
    Height = 16
    Caption = 'Редакт.'
    TabOrder = 11
    OnClick = ButtonEditDoctorClick
  end
  object EditComment: TEdit
    Left = 376
    Top = 267
    Width = 97
    Height = 21
    TabOrder = 24
    OnEnter = EditCommentEnter
  end
  object DateEditDoc: TDateEdit
    Left = 376
    Top = 235
    Width = 97
    Height = 21
    NumGlyphs = 2
    TabOrder = 21
  end
  object RxCalcEditPayPercent: TRxCalcEdit
    Left = 80
    Top = 235
    Width = 81
    Height = 21
    AutoSize = False
    ButtonWidth = 0
    NumGlyphs = 2
    TabOrder = 19
  end
  object EditAkt: TEdit
    Left = 80
    Top = 267
    Width = 81
    Height = 21
    TabOrder = 22
  end
  object DateEditReestr: TDateEdit
    Left = 208
    Top = 235
    Width = 97
    Height = 21
    NumGlyphs = 2
    TabOrder = 20
  end
  object RxCalcEditAktSum: TRxCalcEdit
    Left = 224
    Top = 267
    Width = 81
    Height = 21
    AutoSize = False
    ButtonWidth = 0
    NumGlyphs = 2
    TabOrder = 23
  end
  object ComboBoxBranch: TComboBox
    Left = 79
    Top = 170
    Width = 313
    Height = 21
    ItemHeight = 13
    TabOrder = 13
  end
  object ButtonInsBranch: TButton
    Left = 399
    Top = 181
    Width = 75
    Height = 16
    Caption = 'Добавить'
    TabOrder = 15
    OnClick = ButtonInsBranchClick
  end
  object ButtonEditBranch: TButton
    Left = 399
    Top = 165
    Width = 75
    Height = 16
    Caption = 'Редакт.'
    TabOrder = 14
    OnClick = ButtonEditBranchClick
  end
end
