object NewAutoPayForm: TNewAutoPayForm
  Left = 337
  Top = 225
  Width = 400
  Height = 350
  BorderIcons = [biSystemMenu]
  Caption = 'Автоматический ввод платежей'
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
  object Label7: TLabel
    Left = 8
    Top = 24
    Width = 41
    Height = 13
    Caption = 'Предпр.'
  end
  object Label1: TLabel
    Left = 8
    Top = 72
    Width = 44
    Height = 13
    Caption = 'Договор'
  end
  object Label2: TLabel
    Left = 8
    Top = 93
    Width = 163
    Height = 13
    Caption = 'Файл со скриптом для импорта'
  end
  object Label3: TLabel
    Left = 8
    Top = 141
    Width = 123
    Height = 13
    Caption = 'Файл с базой платежей'
  end
  object Label4: TLabel
    Left = 9
    Top = 248
    Width = 3
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 216
    Width = 26
    Height = 13
    Caption = 'Дата'
  end
  object BitBtnSave: TBitBtn
    Left = 88
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Сохр.'
    Default = True
    TabOrder = 8
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
    Left = 232
    Top = 288
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Отмена'
    TabOrder = 9
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
  object ComboBoxFactory: TComboBox
    Left = 56
    Top = 16
    Width = 241
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object ComboBoxMaxInsur: TComboBox
    Left = 56
    Top = 64
    Width = 241
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
  object EditScriptFile: TEdit
    Left = 56
    Top = 112
    Width = 241
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object ButtonScriptFind: TButton
    Left = 304
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Найти'
    TabOrder = 3
    OnClick = ButtonScriptFindClick
  end
  object EditBaseFile: TEdit
    Left = 56
    Top = 160
    Width = 241
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object ButtonBaseFile: TButton
    Left = 304
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Найти'
    TabOrder = 5
    OnClick = ButtonBaseFileClick
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 240
    Width = 390
    Height = 33
    Min = 0
    Max = 100
    Step = 1
    TabOrder = 7
  end
  object DateEditPayDate: TDateEdit
    Left = 56
    Top = 208
    Width = 105
    Height = 21
    NumGlyphs = 2
    TabOrder = 6
  end
  object OpenDialog: TOpenDialog
    Left = 224
    Top = 224
  end
  object AdsConnectionFactory: TAdsConnection
    IsConnected = False
    ConnectPath = 'c:\dim\factory'
    AdsServerTypes = [stADS_LOCAL]
    LoginPrompt = False
    MiddleTierConnection = False
    StoredProcedureConnection = False
    ReadOnly = False
    Left = 304
    Top = 224
  end
  object AdsQueryFactory: TAdsQuery
    DatabaseName = 'AdsConnectionFactory'
    StoreActive = True
    Version = '6.2 (ACE 8.10)'
    AdsTableOptions.AdsCharType = OEM
    ReadAllColumns = False
    SQL.Strings = (
      'select '
      #39' '#39' as TIN,'
      'FI as ClientName,'
      'CONVERT(CE, SQL_CHAR) AS Fact,'
      'CONVERT(TB, SQL_DOUBLE) AS TabN, '
      'CONVERT('#39'1900-01-01'#39',SQL_DATE) as BirthDate,'
      #39' '#39' as Addr,'
      #39' '#39' as Passport,'
      'CONVERT('#39'1900-01-01'#39',SQL_DATE) as TermDate,'
      'CONVERT(RTRIM(CONVERT(GS,SQL_CHAR))+'#39'-'#39
      '+RTRIM(REPEAT('#39'0'#39',2-LENGTH(CONVERT(MS,SQL_CHAR))))'
      '+RTRIM(CONVERT(MS,SQL_CHAR))+'#39'-01'#39',SQL_DATE) as FinDate,'
      'CONVERT("SUM", SQL_DOUBLE) as Finance'
      'from TempDBF ')
    SourceTableType = ttAdsCDX
    Left = 344
    Top = 224
    ParamData = <>
  end
  object AsaStoredProcGetClientID: TAsaStoredProc
    Params.Data = {
      01FFFF7F060000000900000040436C69656E7449440900000040436C69656E74
      49440204000000000000000100020A00000040436C69656E744E756D0A000000
      40436C69656E744E756D0204000000000000000100010B00000040466163746F
      72794E756D0B00000040466163746F72794E756D020400000000000000010001
      0500000040466163740500000040466163740102000000300001000105000000
      405461624E05000000405461624E010200000030000100010C000000404D6178
      496E7375724E756D0C000000404D6178496E7375724E756D0204000000000000
      00010001}
    Session = DataModuleHM.AsaSessionHM
    StoredProcName = 'DBA.GetClientID'
    Left = 184
    Top = 224
  end
end
