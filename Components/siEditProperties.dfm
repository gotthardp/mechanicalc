object FoProperties: TFoProperties
  Left = 358
  Top = 301
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Vlastnosti'
  ClientHeight = 90
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object BuOK: TButton
    Left = 160
    Top = 24
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 0
  end
  object BuStorno: TButton
    Left = 160
    Top = 56
    Width = 75
    Height = 25
    Caption = '&Storno'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 73
    Caption = '&Zaokrouhlov'#225'n'#237
    TabOrder = 2
    object RaNone: TRadioButton
      Left = 8
      Top = 16
      Width = 57
      Height = 17
      Caption = #381#225'&dn'#233
      TabOrder = 0
      OnClick = RaNoneClick
    end
    object RaNorma: TRadioButton
      Left = 8
      Top = 32
      Width = 81
      Height = 17
      Caption = 'Podle &normy'
      TabOrder = 1
      OnClick = RaNormaClick
    end
    object RaUser: TRadioButton
      Left = 8
      Top = 48
      Width = 81
      Height = 17
      Caption = '&U'#382'ivatelsk'#233
      TabOrder = 2
      OnClick = RaUserClick
    end
    object EdUser: TEdit
      Left = 96
      Top = 45
      Width = 33
      Height = 21
      TabOrder = 3
      Text = '3'
    end
  end
end
