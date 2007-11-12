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
unit LibProfLn;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes;

type
  TProfLn = class(TCommonForm)
    LaLnMater: TLabel;
    LaLnRozmer: TLabel;
    LaLnDelka: TLabel;
    EdLnMater: TClrComboBox;
    EdLnRozmer: TClrComboBox;
    EdLnDelka: TsiEdit;
    ScrLn: TScrollBox;
    LaLnHmot: TLabel;
    LaLnPlocha: TLabel;
    EdLnPlocha: TsiComboEdit;
    EdLnHmot: TsiComboEdit;
    procedure EdLnMaterCreate(Sender: TObject);
    procedure EdLnRozmerCreate(Sender: TObject);
    procedure EdLnHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdLnPlochaCompute(Sender: TObject; var Value: Extended);
    procedure EdLnChange(Sender: TObject);

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

const {staticke parametry nerovnoramenneho L profilu}
      PocLnPro=44;
      ProfilLn:array[0..PocLnPro-1] of record
                prurez:string;
                hmota:single; {hmotnosti v kg/m}
                povrch:single; {plocha v m2 na metr}
              end=((prurez:'30.20.3'; hmota:1.12; povrch:0.10),
                   (prurez:'30.20.4'; hmota:1.46; povrch:0.10),
                   (prurez:'40.25.3'; hmota:1.47; povrch:0.13),
                   (prurez:'40.25.4'; hmota:1.93; povrch:0.13),
                   (prurez:'40.25.5'; hmota:2.37; povrch:0.13),
                   (prurez:'45.30.4'; hmota:2.24; povrch:0.15),
                   (prurez:'45.30.5'; hmota:2.76; povrch:0.15),
                   (prurez:'50.30.4'; hmota:2.42; povrch:0.16),
                   (prurez:'50.30.5'; hmota:2.97; povrch:0.16),
                   (prurez:'60.40.5'; hmota:3.76; povrch:0.19),
                   (prurez:'60.40.6'; hmota:4.46; povrch:0.19),
                   (prurez:'60.40.7'; hmota:5.14; povrch:0.19),
                   (prurez:'70.45.5'; hmota:4.39; povrch:0.22),
                   (prurez:'70.45.6'; hmota:5.21; povrch:0.22),
                   (prurez:'75.50.5'; hmota:4.75; povrch:0.24),
                   (prurez:'75.50.6'; hmota:5.65; povrch:0.24),
                   (prurez:'75.50.7'; hmota:6.53; povrch:0.24),
                   (prurez:'75.50.8'; hmota:7.39; povrch:0.24),
                   (prurez:'80.50.5'; hmota:4.99; povrch:0.25),
                   (prurez:'80.50.6'; hmota:5.92; povrch:0.25),
                   (prurez:'80.50.8'; hmota:7.72; povrch:0.25),
                   (prurez:'80.60.6'; hmota:6.37; povrch:0.27),
                   (prurez:'80.60.7'; hmota:7.36; povrch:0.27),
                   (prurez:'80.60.8'; hmota:8.34; povrch:0.27),
                   (prurez:'90.60.6'; hmota:6.84; povrch:0.29),
                   (prurez:'90.60.8'; hmota:8.97; povrch:0.29),
                   (prurez:'100.65.7'; hmota:8.77; povrch:0.32),
                   (prurez:'100.65.8'; hmota:9.94; povrch:0.32),
                   (prurez:'100.65.10'; hmota:12.3; povrch:0.32),
                   (prurez:'100.65.12'; hmota:14.5; povrch:0.32),
                   (prurez:'110.70.8'; hmota:10.9; povrch:0.35),
                   (prurez:'110.70.10'; hmota:13.4; povrch:0.35),
                   (prurez:'110.70.12'; hmota:15.9; povrch:0.35),
                   (prurez:'120.80.8'; hmota:12.2; povrch:0.39),
                   (prurez:'120.80.10'; hmota:15.0; povrch:0.39),
                   (prurez:'120.80.12'; hmota:17.8; povrch:0.39),
                   (prurez:'140.90.8'; hmota:14.0; povrch:0.45),
                   (prurez:'140.90.10'; hmota:17.4; povrch:0.45),
                   (prurez:'140.90.12'; hmota:20.6; povrch:0.45),
                   (prurez:'140.90.14'; hmota:23.8; povrch:0.45),
                   (prurez:'160.100.10'; hmota:19.7; povrch:0.51),
                   (prurez:'160.100.12'; hmota:23.5; povrch:0.51),
                   (prurez:'160.100.14'; hmota:27.2; povrch:0.51),
                   (prurez:'160.100.16'; hmota:30.80; povrch:0.51));

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\Ln';
  Result.Trida := TProfLn.Create( AOwner );
end;

{ --- Ln profil ------------------------------------------------------------- }

procedure TProfLn.EdLnMaterCreate(Sender: TObject);
begin
  EdLnMater.Items.Add('Ocel');
  EdLnMater.ItemIndex:=0;
end;

procedure TProfLn.EdLnRozmerCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to PocLnPro-1 do EdLnRozmer.Items.Add(ProfilLn[pocitam].prurez);
end;

procedure TProfLn.EdLnHmotCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilLn[EdLnRozmer.ItemIndex].hmota*EdLnDelka.Value;
end;

procedure TProfLn.EdLnPlochaCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilLn[EdLnRozmer.ItemIndex].povrch*EdLnDelka.Value*1000;
end;

procedure TProfLn.EdLnChange(Sender: TObject);
begin
  EdLnHmot.Recompute;
  EdLnPlocha.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TProfLn.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

