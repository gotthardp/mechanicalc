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
unit LibObdelnik;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes;

type
  TObdelnik = class(TCommonForm)
    LaObMater: TLabel;
    LaObRozmer: TLabel;
    LaObDelka: TLabel;
    EdObMater: TClrComboBox;
    EdObRozmer: TClrComboBox;
    EdObDelka: TsiEdit;
    ScrOb: TScrollBox;
    LaObHmot: TLabel;
    LaObPlocha: TLabel;
    EdObPlocha: TsiComboEdit;
    EdObHmot: TsiComboEdit;
    procedure EdObMaterCreate(Sender: TObject);
    procedure EdObRozmerCreate(Sender: TObject);
    procedure EdObHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdObPlochaCompute(Sender: TObject; var Value: Extended);
    procedure EdObChange(Sender: TObject);

    procedure EdButtonClick(Sender: TObject);
  protected
    { Protected declarations }
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function RegisterPage(AOwner: TComponent): TVypocty;

implementation

{$R *.DFM}

uses
  Graphics, Math;

const {staticke hodnoty tenkostennych obdelniku}
      PocObPro=39;
      ProfilOb:array[0..PocObPro-1] of record
                rozmer:string;
                hmota:single; {hmotnosti v kg/m}
                povrch:single; {plocha v m2 na metr}
                {povrch vypocten dle vztahu 2*A+2*B-8*R+2*pi*R}
              end=((rozmer:'25.15 - 1,5'; hmota:0.79; povrch:0.0774),
                   (rozmer:'30.15 - 2,0'; hmota:1.29; povrch:0.0865),
                   (rozmer:'30.18 - 2,0'; hmota:1.38; povrch:0.0925),
                   (rozmer:'35.20 - 1,5'; hmota:1.23; povrch:0.1074),
                   (rozmer:'35.20 - 2,0'; hmota:1.60; povrch:0.1066),
                   (rozmer:'40.12 - 2,0'; hmota:1.51; povrch:0.1005),
                   (rozmer:'40.20 - 1,5'; hmota:1.32; povrch:0.1174),
                   (rozmer:'40.20 - 2,0'; hmota:1.76; povrch:0.1166),
                   (rozmer:'40.20 - 3,0'; hmota:2.56; povrch:0.1148),
                   (rozmer:'40.27 - 2,0'; hmota:1.98; povrch:0.1306),
                   (rozmer:'40.35 - 2,0'; hmota:2.23; povrch:0.1466),
                   (rozmer:'40.35 - 2,5'; hmota:2.74; povrch:0.1457),
                   (rozmer:'40.35 - 3,0'; hmota:3.25; povrch:0.1448),
                   (rozmer:'50.20 - 1,5'; hmota:1.68; povrch:0.1374),
                   (rozmer:'50.20 - 2,0'; hmota:2.07; povrch:0.1365),
                   (rozmer:'50.30 - 1,5'; hmota:1.81; povrch:0.1574),
                   (rozmer:'50.30 - 2,0'; hmota:2.39; povrch:0.1566),
                   (rozmer:'50.35 - 1,5'; hmota:1.93; povrch:0.1674),
                   (rozmer:'50.35 - 2,0'; hmota:2.54; povrch:0.1666),
                   (rozmer:'50.35 - 3,0'; hmota:3.72; povrch:0.1648),
                   (rozmer:'60.20 - 1,5'; hmota:1.93; povrch:0.1574),
                   (rozmer:'60.20 - 2,0'; hmota:2.39; povrch:0.1566),
                   (rozmer:'60.40 - 2,0'; hmota:3.01; povrch:0.1966),
                   (rozmer:'60.40 - 2,5'; hmota:3.68; povrch:0.1957),
                   (rozmer:'60.40 - 3,0'; hmota:4.43; povrch:0.1948),
                   (rozmer:'70.35 - 2,0'; hmota:3.17; povrch:0.2065),
                   (rozmer:'70.50 - 2,5'; hmota:4.40; povrch:0.2357),
                   (rozmer:'70.50 - 3,0'; hmota:5.23; povrch:0.2348),
                   (rozmer:'70.60 - 3,0'; hmota:5.66; povrch:0.2548),
                   (rozmer:'80.30 - 2,0'; hmota:3.33; povrch:0.2165),
                   (rozmer:'80.35 - 2,0'; hmota:3.94; povrch:0.2265),
                   (rozmer:'80.35 - 3,0'; hmota:5.13; povrch:0.2248),
                   (rozmer:'80.40 - 2,0'; hmota:3.64; povrch:0.2366),
                   (rozmer:'90.40 - 3,0'; hmota:5.84; povrch:0.2548),
                   (rozmer:'100.40 - 2,0'; hmota:4.19; povrch:0.2765),
                   (rozmer:'100.60 - 2,5'; hmota:5.98; povrch:0.3157),
                   (rozmer:'100.60 - 3,0'; hmota:6.99; povrch:0.3148),
                   (rozmer:'120.60 - 3,0'; hmota:7.94; povrch:0.3548),
                   (rozmer:'120.85 - 3,0'; hmota:9.11; povrch:0.4048));

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\Obdélník';
  Result.Trida := TObdelnik.Create( AOwner );
end;

{ --- Obdélník -------------------------------------------------------------- }

procedure TObdelnik.EdObMaterCreate(Sender: TObject);
begin
  EdObMater.Items.Add('Ocel');
  EdObMater.ItemIndex:=0;
end;

procedure TObdelnik.EdObRozmerCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to PocObPro-1 do EdObRozmer.Items.Add(ProfilOb[pocitam].rozmer);
end;

procedure TObdelnik.EdObHmotCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilOb[EdObRozmer.ItemIndex].hmota*EdObDelka.Value;
end;

procedure TObdelnik.EdObPlochaCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilOb[EdObRozmer.ItemIndex].povrch*EdObDelka.Value*1000;
end;

procedure TObdelnik.EdObChange(Sender: TObject);
begin
  EdObHmot.Recompute;
  EdObPlocha.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TObdelnik.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

