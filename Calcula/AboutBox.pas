{
    Zdrojový kód Strojírenského kalkulátoru

    Copyright (c) 1997-2007  Petr Gotthard
    email - petr.gotthard@centrum.cz

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    $Id: AnyBnfFile.cpp 22 2007-09-26 17:51:41Z gotthardp $
}

{$B-}
unit AboutBox;

interface

uses
  Forms, Controls, StdCtrls, Graphics, ExtCtrls, Classes;

type
  TAboutBox = class(TForm)
    BuOK: TButton;
    LaCopyright: TLabel;
    Bevel1: TBevel;
    LaVersion: TLabel;
    ImIcon: TImage;
    LaTitle: TLabel;
    LaLicence: TLabel;
    LaLink: TLabel;
    procedure LaLinkDblClick(Sender: TObject);
    procedure LaLinkMouseEnter(Sender: TObject);
    procedure LaLinkMouseLeave(Sender: TObject);
  end;

procedure ShowAboutBox;

implementation

uses Windows, ShellAPI;

{$R *.DFM}

procedure ShowAboutBox;
begin
  with TAboutBox.Create(Application) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TAboutBox.LaLinkDblClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, PChar('open'),
    PChar(LaLink.Caption), PChar(0), nil, SW_NORMAL);
end;

procedure TAboutBox.LaLinkMouseEnter(Sender: TObject);
begin
  LaLink.Font.Color := clNavy;
  LaLink.Font.Style := [fsUnderline];
end;

procedure TAboutBox.LaLinkMouseLeave(Sender: TObject);
begin
  LaLink.Font.Color := clBtnText;
  LaLink.Font.Style := [];
end;

end.

