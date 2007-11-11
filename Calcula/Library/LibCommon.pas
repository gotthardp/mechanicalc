{
    Zdrojový kód Strojírenského kalkulátoru

    Copyright (c) 1997-2007 Petr Gotthard
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
unit LibCommon;

interface

uses
  Forms, Classes, siEdit;

type
  TCommonForm = class(TForm)
  protected
    EdZadani: TsiEdit;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TVypocty = record
    Name: string;
    Trida: TCommonForm;
  end;
  TRegistrace = Function(AOwner: TComponent): TVypocty;

const Latek=14;
      Latky:array[0..Latek-1] of record
                nazev:string;
                hustota:double;  { hustota v kg/m3 }
                roztah:double;   { teplotni roztaznost v 10e6 * 1/K }
                pruznost:double; { modul pruznosti E v 10e10 * Pa }
              end=((nazev:'Ocel';hustota:7850; roztah:12.0; pruznost:21.0),
                   (nazev:'Hliník';hustota:2699; roztah:23.8; pruznost:7.07),
                   (nazev:'Mìï';hustota:8960; roztah:16.8; pruznost:12.3),
                   (nazev:'Mosaz';hustota:8600; roztah:0; pruznost:9.9),
                   (nazev:'Olovo';hustota:11341; roztah:31.3; pruznost:1.6),
                   (nazev:'Borovice';hustota:500; roztah:34.0; pruznost:1.2),
                   (nazev:'Dub';hustota:700; roztah:54.4; pruznost:1.3),
                   (nazev:'Beton';hustota:2400; roztah:12.0; pruznost:4.5),
                   (nazev:'PA, PS';hustota:1100; roztah:0; pruznost:0.32),
                   (nazev:'PE';hustota:1900; roztah:0; pruznost:0),
                   (nazev:'PTFE';hustota:2200; roztah:0; pruznost:0),
                   (nazev:'Pryž';hustota:1100; roztah:0; pruznost:0.0005),
                   (nazev:'Sklo';hustota:2500; roztah:7.8; pruznost:6.5),
                   (nazev:'Voda';hustota:1000; roztah:0; pruznost:0));

implementation

uses MainForm;

constructor TCommonForm.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  EdZadani := (AOwner as TCalcMain).EdZadani;
end;

destructor TCommonForm.Destroy;
begin
  inherited Destroy;
end;

end.

