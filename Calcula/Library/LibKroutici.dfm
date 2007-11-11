object Kroutici: TKroutici
  Left = 328
  Top = 157
  HelpContext = 1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Krout'#237'c'#237' moment'
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
  object LaKrVykon: TLabel
    Left = 8
    Top = 34
    Width = 50
    Height = 13
    Caption = '&V'#253'kon [W]'
    FocusControl = EdKrVykon
  end
  object LaKrMoment: TLabel
    Left = 88
    Top = 34
    Width = 63
    Height = 13
    Caption = '&Moment [Nm]'
    FocusControl = EdKrMoment
  end
  object LaKrOtacky: TLabel
    Left = 168
    Top = 34
    Width = 57
    Height = 13
    Caption = '&Ot'#225#269'ky [s-1]'
  end
  object VzKrou: TLabel
    Left = 8
    Top = 8
    Width = 63
    Height = 13
    Caption = 'P = Mk'#183'2'#183'pi'#183'n'
  end
  object EdKrVykon: TsiComboEdit
    Left = 8
    Top = 48
    Width = 75
    Height = 21
    Hint = 'V'#253'kon motoru'
    ButtonHint = 'P'#345'epo'#269#237't'#225' v'#253'kon motoru'
    Caption = '&V'#253'kon'
    ColorOK = clWindow
    ColorError = 13172735
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HelpProperties = 4
    HintOK = 'V'#253'kon motoru'
    Glyph.Data = {
      E6000000424DE60000000000000076000000280000000F0000000E0000000100
      0400000000007000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFF0F0078FFFFFFFFFF0F0B3078FFFFFFFF0FF0BB0078FFFFFF0FFF0BB3007FF
      FFF0FFFF0BBB007FFFF0FFFF00BBB008FFF0FFF00BBB008FFFF0FFFF00BBB008
      FFF0FFFFFF00BB008FF0FFFFFFFF00B008F0FFFFFFFFFF000FF0FFFFFFFFFFFF
      FFF0FFFFFFFFFFFFFFF0}
    ButtonWidth = 18
    Measure = meNone
    NumGlyphs = 1
    Options = [RoundItem, SaveState]
    ParentFont = False
    ParentShowHint = False
    PopupMenu = EdKrVykon.Popup
    Round = roCSN
    RoundUser = 3
    ShowHint = True
    TabOrder = 0
    Text = '0'
    Units = UN_W
    UnitLabel = LaKrVykon
    OnButtonClick = KrVykon
    OnCompute = EdKrVykonCompute
  end
  object EdKrMoment: TsiComboEdit
    Left = 88
    Top = 48
    Width = 75
    Height = 21
    Hint = 'Krout'#237'c'#237' moment'
    ButtonHint = 'P'#345'epo'#269#237't'#225' krout'#237'c'#237' moment'
    Caption = '&Moment'
    ColorOK = clWindow
    ColorError = 13172735
    HelpProperties = 4
    HintOK = 'Krout'#237'c'#237' moment'
    Glyph.Data = {
      E6000000424DE60000000000000076000000280000000F0000000E0000000100
      0400000000007000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFF0F0078FFFFFFFFFF0F0B3078FFFFFFFF0FF0BB0078FFFFFF0FFF0BB3007FF
      FFF0FFFF0BBB007FFFF0FFFF00BBB008FFF0FFF00BBB008FFFF0FFFF00BBB008
      FFF0FFFFFF00BB008FF0FFFFFFFF00B008F0FFFFFFFFFF000FF0FFFFFFFFFFFF
      FFF0FFFFFFFFFFFFFFF0}
    ButtonWidth = 18
    Measure = meNone
    NumGlyphs = 1
    Options = [RoundItem, SaveState]
    ParentShowHint = False
    PopupMenu = EdKrMoment.Popup
    Round = roCSN
    RoundUser = 3
    ShowHint = True
    TabOrder = 1
    Text = '0'
    Units = UN_Nm
    UnitLabel = LaKrMoment
    OnButtonClick = KrMoment
    OnCompute = EdKrMomentCompute
  end
  object EdKrOtacky: TsiComboEdit
    Left = 168
    Top = 48
    Width = 75
    Height = 21
    Hint = 'Po'#269'et ot'#225#269'ek'
    ButtonHint = 'P'#345'epo'#269#237't'#225' po'#269'et ot'#225#269'ek'
    Caption = '&Ot'#225#269'ky'
    ColorOK = clWindow
    ColorError = 13172735
    HelpProperties = 4
    HintOK = 'Po'#269'et ot'#225#269'ek'
    Glyph.Data = {
      E6000000424DE60000000000000076000000280000000F0000000E0000000100
      0400000000007000000000000000000000001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFF0F0078FFFFFFFFFF0F0B3078FFFFFFFF0FF0BB0078FFFFFF0FFF0BB3007FF
      FFF0FFFF0BBB007FFFF0FFFF00BBB008FFF0FFF00BBB008FFFF0FFFF00BBB008
      FFF0FFFFFF00BB008FF0FFFFFFFF00B008F0FFFFFFFFFF000FF0FFFFFFFFFFFF
      FFF0FFFFFFFFFFFFFFF0}
    ButtonWidth = 18
    Measure = meNone
    NumGlyphs = 1
    Options = [RoundItem, SaveState]
    ParentShowHint = False
    PopupMenu = EdKrOtacky.Popup
    Round = roCSN
    RoundUser = 3
    ShowHint = True
    TabOrder = 2
    Text = '0'
    Units = UN_1s
    UnitLabel = LaKrOtacky
    OnButtonClick = KrOtacky
    OnCompute = EdKrOtackyCompute
  end
end
