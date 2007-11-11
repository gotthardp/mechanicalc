object Ctverec: TCtverec
  Left = 234
  Top = 255
  HelpContext = 1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tenkost'#283'nn'#253' '#269'tvercov'#253' profil'
  ClientHeight = 121
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDefaultPosOnly
  PixelsPerInch = 96
  TextHeight = 13
  object LaCtMater: TLabel
    Left = 8
    Top = 2
    Width = 37
    Height = 13
    Caption = '&Materi'#225'l'
    FocusControl = EdCtMater
  end
  object LaCtRozmer: TLabel
    Left = 8
    Top = 42
    Width = 77
    Height = 13
    Caption = #352#237#345'ka - &Tlou'#353#357'ka'
    FocusControl = EdCtRozmer
  end
  object LaCtDelka: TLabel
    Left = 104
    Top = 42
    Width = 45
    Height = 13
    Caption = '&D'#233'lka [m]'
    FocusControl = EdCtDelka
  end
  object EdCtMater: TClrComboBox
    Left = 8
    Top = 16
    Width = 97
    Height = 21
    Hint = 'Materi'#225'l '#269'tvercov'#233'ho profilu'
    Style = csOwnerDrawVariable
    Enabled = False
    ItemHeight = 16
    Options = []
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = EdCtChange
    OnCreate = EdCtMaterCreate
  end
  object EdCtRozmer: TClrComboBox
    Left = 8
    Top = 56
    Width = 89
    Height = 21
    Hint = 'Rozm'#283'ry '#269'tvercov'#233'ho profilu'
    Style = csOwnerDrawVariable
    ItemHeight = 16
    Options = [SaveState]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnChange = EdCtChange
    OnCreate = EdCtRozmerCreate
  end
  object EdCtDelka: TsiEdit
    Left = 104
    Top = 56
    Width = 75
    Height = 21
    Hint = 'D'#233'lka '#269'tvercov'#233'ho profilu'
    Caption = '&D'#233'lka'
    ColorOK = clWindow
    ColorError = 13172735
    HelpProperties = 4
    HintOK = 'D'#233'lka '#269'tvercov'#233'ho profilu'
    Measure = meDistance
    Options = [RoundItem, SaveState]
    ParentShowHint = False
    Round = roCSN
    RoundUser = 3
    ShowHint = True
    TabOrder = 2
    Text = '0'
    Units = UN_m
    UnitLabel = LaCtDelka
    OnChange = EdCtChange
  end
  object ScrCt: TScrollBox
    Left = 254
    Top = 0
    Width = 115
    Height = 121
    HorzScrollBar.Visible = False
    Align = alRight
    BorderStyle = bsNone
    TabOrder = 3
    object LaCtHmot: TLabel
      Left = 0
      Top = 2
      Width = 66
      Height = 13
      Caption = '&Hmotnost [kg]'
      FocusControl = EdCtHmot
    end
    object LaCtPlocha: TLabel
      Left = 0
      Top = 42
      Width = 56
      Height = 13
      Caption = '&Plocha [m2]'
      FocusControl = EdCtHmot
    end
    object EdCtPlocha: TsiComboEdit
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
      PopupMenu = EdCtPlocha.Popup
      Round = roCSN
      RoundUser = 3
      ShowHint = True
      TabOrder = 0
      Text = '0'
      Units = UN_m2
      UnitLabel = LaCtPlocha
      OnButtonClick = EdButtonClick
      OnCompute = EdCtPlochaCompute
    end
    object EdCtHmot: TsiComboEdit
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
      PopupMenu = EdCtHmot.Popup
      Round = roCSN
      RoundUser = 3
      ShowHint = True
      TabOrder = 1
      Text = '0'
      Units = UN_kg
      UnitLabel = LaCtHmot
      OnButtonClick = EdButtonClick
      OnCompute = EdCtHmotCompute
    end
  end
end
