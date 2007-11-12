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

    $Id$
}

{$B-}
unit LibCtverec;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes;

type
  TCtverec = class(TCommonForm)
    LaCtMater: TLabel;
    EdCtMater: TClrComboBox;
    LaCtRozmer: TLabel;
    EdCtRozmer: TClrComboBox;
    EdCtDelka: TsiEdit;
    LaCtDelka: TLabel;
    ScrCt: TScrollBox;
    LaCtHmot: TLabel;
    LaCtPlocha: TLabel;
    EdCtPlocha: TsiComboEdit;
    EdCtHmot: TsiComboEdit;
    procedure EdCtMaterCreate(Sender: TObject);
    procedure EdCtRozmerCreate(Sender: TObject);
    procedure EdCtHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdCtPlochaCompute(Sender: TObject; var Value: Extended);
    procedure EdCtChange(Sender: TObject);

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
  Graphics;

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\Ètverec';
  Result.Trida := TCtverec.Create( AOwner );
end;

{ --- Ètverec --------------------------------------------------------------- }

{staticke hodnoty tenkostennych ctvercu}
const PocCtPro=26;
      ProfilCt:array[0..PocCtPro-1] of record
                rozmer:string;
                hmota:single; {hmotnosti v kg/m}
                povrch:single; {plocha nateru v m2 na metr}
                {povrch vypocten dle vztahu 4*A-8*R+2*pi*R}
              end=((rozmer:'15 - 1,25'; hmota:0.54; povrch:0.0578),
                   (rozmer:'15 - 1,50'; hmota:0.64; povrch:0.0574),
                   (rozmer:'20 - 1,25'; hmota:0.74; povrch:0.0778),
                   (rozmer:'20 - 1,50'; hmota:0.87; povrch:0.0774),
                   (rozmer:'20 - 2,00'; hmota:1.13; povrch:0.0766),
                   (rozmer:'25 - 1,50'; hmota:1.11; povrch:0.0974),
                   (rozmer:'25 - 2,00'; hmota:1.44; povrch:0.0965),
                   (rozmer:'30 - 1,50'; hmota:1.34; povrch:0.1174),
                   (rozmer:'30 - 2,00'; hmota:1.76; povrch:0.1165),
                   (rozmer:'35 - 1,50'; hmota:1.58; povrch:0.1374),
                   (rozmer:'35 - 2,00'; hmota:2.07; povrch:0.1365),
                   (rozmer:'35 - 2,50'; hmota:2.55; povrch:0.1357),
                   (rozmer:'35 - 3,00'; hmota:3.01; povrch:0.1348),
                   (rozmer:'40 - 2,0'; hmota:2.39; povrch:0.1566),
                   (rozmer:'40 - 2,5'; hmota:2.94; povrch:0.1557),
                   (rozmer:'40 - 3,0'; hmota:2.49; povrch:0.1548),
                   (rozmer:'45 - 2,0'; hmota:2.70; povrch:0.1766),
                   (rozmer:'45 - 2,5'; hmota:3.33; povrch:0.1757),
                   (rozmer:'45 - 3,0'; hmota:3.96; povrch:0.1748),
                   (rozmer:'50 - 1,5'; hmota:2.27; povrch:0.1974),
                   (rozmer:'50 - 2,0'; hmota:3.01; povrch:0.1966),
                   (rozmer:'50 - 2,5'; hmota:3.73; povrch:0.1957),
                   (rozmer:'50 - 3,0'; hmota:4.43; povrch:0.1948),
                   (rozmer:'55 - 2,0'; hmota:3.33; povrch:0.2166),
                   (rozmer:'60 - 2,0'; hmota:3.64; povrch:0.2365),
                   (rozmer:'60 - 3,0'; hmota:5.37; povrch:0.2348));

procedure TCtverec.EdCtMaterCreate(Sender: TObject);
begin
  EdCtMater.Items.Add('Ocel');
  EdCtMater.ItemIndex:=0;
end;

procedure TCtverec.EdCtRozmerCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to PocCtPro-1 do EdCtRozmer.Items.Add(ProfilCt[pocitam].rozmer);
end;

procedure TCtverec.EdCtHmotCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilCt[EdCtRozmer.ItemIndex].hmota*EdCtDelka.Value;
end;

procedure TCtverec.EdCtPlochaCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilCt[EdCtRozmer.ItemIndex].povrch*EdCtDelka.Value*1000;
end;

procedure TCtverec.EdCtChange(Sender: TObject);
begin
  EdCtHmot.Recompute;
  EdCtPlocha.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TCtverec.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

