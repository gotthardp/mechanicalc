object ProfU: TProfU
  Left = 227
  Top = 115
  HelpContext = 1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'U profil'
  ClientHeight = 121
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000003000000000003300B303B00000000B30F33B000000
    0030BFBFB0306644403BF000FB306F66630F07F003006E60FF03B7F03B006F66
    663B07F006006E60F0330770F0406F666666666666406E088888886666406F0F
    FFFFF86666406E000000006666406FEFEFEFEFEFEF600666666666666660FF87
    0000FC810000FC000000FC010000800000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000080010000}
  OldCreateOrder = True
  Position = poDefaultPosOnly
  PixelsPerInch = 96
  TextHeight = 13
  object LaUMater: TLabel
    Left = 8
    Top = 2
    Width = 37
    Height = 13
    Caption = '&Materi'#225'l'
    FocusControl = EdUMater
  end
  object LaURozmer: TLabel
    Left = 8
    Top = 42
    Width = 31
    Height = 13
    Caption = '&Pr'#367#345'ez'
    FocusControl = EdURozmer
  end
  object LaUDelka: TLabel
    Left = 104
    Top = 42
    Width = 45
    Height = 13
    Caption = '&D'#233'lka [m]'
    FocusControl = EdUDelka
  end
  object EdUMater: TClrComboBox
    Left = 8
    Top = 16
    Width = 97
    Height = 21
    Hint = 'Materi'#225'l U profilu'
    Style = csOwnerDrawVariable
    Enabled = False
    ItemHeight = 16
    Options = []
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = EdUChange
    OnCreate = EdUMaterCreate
  end
  object EdURozmer: TClrComboBox
    Left = 8
    Top = 56
    Width = 89
    Height = 21
    Hint = 'Pr'#367#345'ez U profilu'
    Style = csOwnerDrawVariable
    ItemHeight = 16
    Options = [SaveState]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnChange = EdUChange
    OnCreate = EdURozmerCreate
  end
  object EdUDelka: TsiEdit
    Left = 104
    Top = 56
    Width = 75
    Height = 21
    Hint = 'D'#233'lka U profilu'
    Caption = '&D'#233'lka'
    ColorOK = clWindow
    ColorError = 13172735
    HelpProperties = 4
    HintOK = 'D'#233'lka U profilu'
    Measure = meDistance
    Options = [RoundItem, SaveState]
    ParentShowHint = False
    Round = roCSN
    RoundUser = 3
    ShowHint = True
    TabOrder = 2
    Text = '0'
    Units = UN_m
    UnitLabel = LaUDelka
    OnChange = EdUChange
  end
  object ScrU: TScrollBox
    Left = 254
    Top = 0
    Width = 115
    Height = 121
    HorzScrollBar.Visible = False
    Align = alRight
    BorderStyle = bsNone
    TabOrder = 3
    object LaUHmot: TLabel
      Left = 0
      Top = 2
      Width = 66
      Height = 13
      Caption = '&Hmotnost [kg]'
      FocusControl = EdUHmot
    end
    object LaUPlocha: TLabel
      Left = 0
      Top = 42
      Width = 56
      Height = 13
      Caption = '&Plocha [m2]'
      FocusControl = EdUPlocha
    end
    object EdUPlocha: TsiComboEdit
      Left = 0
      Top = 56
      Width = 97
      Height = 21
      Hint = 'N'#225't'#283'rov'#225' plocha'
      ButtonHint = 'Vlo'#382#237' hodnotu do v'#253'razu'
      Caption = '&Plocha'
      ColorOK = clWindow
      ColorError = 13172735
      DirectInput = False
      HelpProperties = 4
      HintOK = 'N'#225't'#283'rov'#225' plocha'
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000D0000000C0000000100
        0400000000006000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333334
        3F6800000000034445920BFBFBFB044434F40F88874F444338C60BFBFB4C4433
        38E50F888744C3333F000BFBFB44443330070F88887F0333392E0BFBFBFB0333
        320B0FFFFF88033338150BFBFB803333388D0000000333333805}
      ButtonWidth = 18
      Measure = meNone
      NumGlyphs = 1
      Options = [RoundItem, SaveState]
      ParentShowHint = False
      PopupMenu = EdUPlocha.Popup
      Round = roCSN
      RoundUser = 3
      ShowHint = True
      TabOrder = 0
      Text = '0'
      Units = UN_m2
      UnitLabel = LaUPlocha
      OnButtonClick = EdButtonClick
      OnCompute = EdUPlochaCompute
    end
    object EdUHmot: TsiComboEdit
      Left = 0
      Top = 16
      Width = 97
      Height = 21
      Hint = 'Celkov'#225' hmotnost'
      ButtonHint = 'Vlo'#382#237' hodnotu do v'#253'razu'
      Caption = '&Hmotnost'
      ColorOK = clWindow
      ColorError = 13172735
      DirectInput = False
      HelpProperties = 4
      HintOK = 'Celkov'#225' hmotnost'
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000D0000000C0000000100
        0400000000006000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333334
        3F6800000000034445920BFBFBFB044434F40F88874F444338C60BFBFB4C4433
        38E50F888744C3333F000BFBFB44443330070F88887F0333392E0BFBFBFB0333
        320B0FFFFF88033338150BFBFB803333388D0000000333333805}
      ButtonWidth = 18
      Measure = meNone
      NumGlyphs = 1
      Options = [RoundItem, SaveState]
      ParentShowHint = False
      PopupMenu = EdUHmot.Popup
      Round = roCSN
      RoundUser = 3
      ShowHint = True
      TabOrder = 1
      Text = '0'
      Units = UN_kg
      UnitLabel = LaUHmot
      OnButtonClick = EdButtonClick
      OnCompute = EdUHmotCompute
    end
  end
end
