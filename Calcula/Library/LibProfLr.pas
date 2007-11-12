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
unit LibProfLr;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes;

type
  TProfLr = class(TCommonForm)
    LaLrMater: TLabel;
    LaLrRozmer: TLabel;
    LaLrDelka: TLabel;
    EdLrMater: TClrComboBox;
    EdLrRozmer: TClrComboBox;
    EdLrDelka: TsiEdit;
    ScrLr: TScrollBox;
    LaLrHmot: TLabel;
    LaLrPlocha: TLabel;
    EdLrPlocha: TsiComboEdit;
    EdLrHmot: TsiComboEdit;
    procedure EdLrMaterCreate(Sender: TObject);
    procedure EdLrRozmerCreate(Sender: TObject);
    procedure EdLrHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdLrPlochaCompute(Sender: TObject; var Value: Extended);
    procedure EdLrChange(Sender: TObject);

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

const {staticke parametry rovnoramenneho L profilu}
      PocLrPro=52;
      ProfilLr:array[0..PocLrPro-1] of record
                prurez:string;
                hmota:single; {hmotnosti v kg/m}
                povrch:single; {plocha v m2 na metr}
              end=((prurez:'20.20.3'; hmota:0.879; povrch:0.083),
                   (prurez:'25.25.3'; hmota:1.11; povrch:0.10),
                   (prurez:'25.25.4'; hmota:1.45; povrch:0.10),
                   (prurez:'30.30.3'; hmota:1.36; povrch:0.12),
                   (prurez:'30.30.4'; hmota:1.78; povrch:0.12),
                   (prurez:'32.32.4'; hmota:1.91; povrch:0.12),
                   (prurez:'35.35.3'; hmota:1.60; povrch:0.14),
                   (prurez:'35.35.4'; hmota:2.09; povrch:0.14),
                   (prurez:'40.40.3'; hmota:1.84; povrch:0.15),
                   (prurez:'40.40.4'; hmota:2.42; povrch:0.15),
                   (prurez:'40.40.5'; hmota:2.97; povrch:0.15),
                   (prurez:'45.45.3'; hmota:2.09; povrch:0.17),
                   (prurez:'45.45.4'; hmota:2.74; povrch:0.17),
                   (prurez:'45.45.5'; hmota:3.38; povrch:0.17),
                   (prurez:'50.50.4'; hmota:3.06; povrch:0.19),
                   (prurez:'50.50.5'; hmota:3.77; povrch:0.19),
                   (prurez:'50.50.6'; hmota:4.47; povrch:0.19),
                   (prurez:'55.55.5'; hmota:4.18; povrch:0.21),
                   (prurez:'55.55.6'; hmota:4.95; povrch:0.21),
                   (prurez:'60.60.6'; hmota:5.42; povrch:0.23),
                   (prurez:'65.65.6'; hmota:5.91; povrch:0.25),
                   (prurez:'70.70.5'; hmota:5.38; povrch:0.27),
                   (prurez:'70.70.6'; hmota:6.40; povrch:0.27),
                   (prurez:'70.70.7'; hmota:7.39; povrch:0.27),
                   (prurez:'80.80.6'; hmota:7.34; povrch:0.31),
                   (prurez:'80.80.8'; hmota:9.63; povrch:0.31),
                   (prurez:'80.80.10'; hmota:11.9; povrch:0.31),
                   (prurez:'90.90.6'; hmota:8.28; povrch:0.35),
                   (prurez:'90.90.8'; hmota:10.9; povrch:0.35),
                   (prurez:'90.90.10'; hmota:13.4; povrch:0.35),
                   (prurez:'100.100.6'; hmota:9.26; povrch:0.39),
                   (prurez:'100.100.8'; hmota:12.2; povrch:0.39),
                   (prurez:'100.100.10'; hmota:15.0; povrch:0.39),
                   (prurez:'100.100.12'; hmota:17.8; povrch:0.39),
                   (prurez:'110.110.8'; hmota:13.4; povrch:0.43),
                   (prurez:'110.110.10'; hmota:16.6; povrch:0.43),
                   (prurez:'120.120.10'; hmota:18.2; povrch:0.47),
                   (prurez:'120.120.12'; hmota:21.6; povrch:0.47),
                   (prurez:'130.130.12'; hmota:23.5; povrch:0.51),
                   (prurez:'130.130.14'; hmota:27.2; povrch:0.51),
                   (prurez:'140.140.10'; hmota:21.4; povrch:0.55),
                   (prurez:'140.140.12'; hmota:25.4; povrch:0.55),
                   (prurez:'140.140.14'; hmota:29.4; povrch:0.55),
                   (prurez:'160.160.10'; hmota:24.6; povrch:0.63),
                   (prurez:'160.160.12'; hmota:29.3; povrch:0.63),
                   (prurez:'160.160.14'; hmota:33.9; povrch:0.63),
                   (prurez:'160.160.16'; hmota:38.4; povrch:0.63),
                   (prurez:'180.180.12'; hmota:33.1; povrch:0.70),
                   (prurez:'180.180.14'; hmota:38.3; povrch:0.70),
                   (prurez:'200.200.14'; hmota:42.7; povrch:0.78),
                   (prurez:'200.200.16'; hmota:48.5; povrch:0.78),
                   (prurez:'200.200.20'; hmota:59.5; povrch:0.78));

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\Lr';
  Result.Trida := TProfLr.Create( AOwner );
end;

{ --- Lr profil ------------------------------------------------------------- }

procedure TProfLr.EdLrMaterCreate(Sender: TObject);
begin
  EdLrMater.Items.Add('Ocel');
  EdLrMater.ItemIndex:=0;
end;

procedure TProfLr.EdLrRozmerCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to PocLrPro-1 do EdLrRozmer.Items.Add(ProfilLr[pocitam].prurez);
end;

procedure TProfLr.EdLrHmotCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilLr[EdLrRozmer.ItemIndex].hmota*EdLrDelka.Value;
end;

procedure TProfLr.EdLrPlochaCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilLr[EdLrRozmer.ItemIndex].povrch*EdLrDelka.Value*1000;
end;

procedure TProfLr.EdLrChange(Sender: TObject);
begin
  EdLrHmot.Recompute;
  EdLrPlocha.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TProfLr.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

