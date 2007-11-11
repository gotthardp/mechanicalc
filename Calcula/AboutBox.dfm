object AboutBox: TAboutBox
  Left = 377
  Top = 253
  BorderStyle = bsDialog
  Caption = 'O programu'
  ClientHeight = 258
  ClientWidth = 342
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LaCopyright: TLabel
    Left = 85
    Top = 43
    Width = 182
    Height = 13
    Caption = 'Copyright (c) 1997-2007  Petr Gotthard'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 85
    Top = 148
    Width = 251
    Height = 2
  end
  object LaVersion: TLabel
    Left = 85
    Top = 27
    Width = 45
    Height = 13
    Caption = 'Verze 3.4'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object ImIcon: TImage
    Left = 9
    Top = 11
    Width = 32
    Height = 32
    AutoSize = True
    Picture.Data = {
      055449636F6E0000010001002020100000000000E80200001600000028000000
      2000000040000000010004000000000080020000000000000000000000000000
      0000000000000000000080000080000000808000800000008000800080800000
      80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
      FFFFFF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000770000000000000000000000007000000000
      0007000000000000000000703030BF0303070000000000000000000B0330FB03
      30F0000000000000000000BFB00FBFB00FBF000000000000000370FBFBFBFBFB
      FBFB037066444444440000BFBF000000BFBF00006E666666660BFBFBF00F8770
      0BFBFBF06F660000000000BF0F0F8770F0BF00006E66F8888806F00BF00F8770
      0BF004006F66FFFFFF06F00FBF0F8770BFB004006E666666666660FBFB0F8770
      FBFB04006F660006000600BF0007007000BF04006E66F806F806F800F8078870
      F80064006F66FF06FF06FF06FF0FF880FF0664006E6666666666666666600006
      666664006F6600060006000600060006000664006E66F806F806F806F806F806
      F80664006F66FF06FF06FF06FF06FF06FF0664006E6666666666666666666666
      666664006F6608888888888888866666666664006E660FFFFFFFFFFFFF866666
      666664006F6608888888888888866666666664006E6600000000000000066666
      666664006FEFEFEFEFEFEFEFEFEFEFEFEFEFE400066666666666666666666666
      6666660000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FFFFFFFFFFFFE1FFFFFCE1CFFFF84087FFF80007FFF80007FFE00001
      8000000000000000000000000000000100000001000000010000000100000001
      0000000100000001000000010000000100000001000000010000000100000001
      0000000100000001000000010000000180000003FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF}
    Transparent = True
  end
  object LaTitle: TLabel
    Left = 85
    Top = 11
    Width = 104
    Height = 13
    Caption = 'Stroj'#237'rensk'#253' kalkul'#225'tor'
  end
  object LaLicence: TLabel
    Left = 85
    Top = 156
    Width = 230
    Height = 52
    Caption = 
      'Stroj'#237'rensk'#253' kalkul'#225'tor je absolutn'#283' bez z'#225'ruky.'#13#10'M'#367#382'ete jej '#353#237#345 +
      'it a modifikovat podle ustanoven'#237#13#10'GNU General Public License, v' +
      'erze 2, vyd'#225'van'#233#13#10'Free Software Foundation.'
  end
  object LaLink: TLabel
    Left = 85
    Top = 128
    Width = 168
    Height = 13
    Caption = 'http://mechanicalc.sourceforge.net'
    Transparent = False
    OnDblClick = LaLinkDblClick
    OnMouseEnter = LaLinkMouseEnter
    OnMouseLeave = LaLinkMouseLeave
  end
  object BuOK: TButton
    Left = 256
    Top = 223
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
end
