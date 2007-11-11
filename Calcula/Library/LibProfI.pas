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
unit LibProfI;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes;

type
  TProfI = class(TCommonForm)
    LaIMater: TLabel;
    LaIRozmer: TLabel;
    LaIDelka: TLabel;
    EdIMater: TClrComboBox;
    EdIRozmer: TClrComboBox;
    EdIDelka: TsiEdit;
    ScrI: TScrollBox;
    LaIHmot: TLabel;
    LaIPlocha: TLabel;
    EdIPlocha: TsiComboEdit;
    EdIHmot: TsiComboEdit;
    procedure EdIMaterCreate(Sender: TObject);
    procedure EdIRozmerCreate(Sender: TObject);
    procedure EdIHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdIPlochaCompute(Sender: TObject; var Value: Extended);
    procedure EdIChange(Sender: TObject);

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

const {staticke parametry I profilu}
      PocIPro=19;
      ProfilI:array[0..PocIPro-1] of record
                prurez:string;
                hmota:single; {hmotnosti v kg/m}
                povrch:single; {plocha v m2 na metr}
              end=((prurez:'80'; hmota:5.95; povrch:0.304),
                   (prurez:'100'; hmota:8.32; povrch:0.370),
                   (prurez:'120'; hmota:11.2; povrch:0.439),
                   (prurez:'140'; hmota:14.4; povrch:0.502),
                   (prurez:'160'; hmota:17.9; povrch:0.575),
                   (prurez:'180'; hmota:21.9; povrch:0.640),
                   (prurez:'200'; hmota:26.3; povrch:0.709),
                   (prurez:'220'; hmota:31.1; povrch:0.775),
                   (prurez:'240'; hmota:36.2; povrch:0.844),
                   (prurez:'260'; hmota:41.9; povrch:0.906),
                   (prurez:'280'; hmota:48.0; povrch:0.966),
                   (prurez:'300'; hmota:54.2; povrch:1.03),
                   (prurez:'320'; hmota:61.1; povrch:1.09),
                   (prurez:'340'; hmota:68.1; povrch:1.15),
                   (prurez:'360'; hmota:76.2; povrch:1.21),
                   (prurez:'380'; hmota:84.0; povrch:1.27),
                   (prurez:'400'; hmota:92.6; povrch:1.33),
                   (prurez:'450'; hmota:115.0; povrch:1.48),
                   (prurez:'500'; hmota:141.0; povrch:1.63));

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\I';
  Result.Trida := TProfI.Create( AOwner );
end;

{ --- I profil -------------------------------------------------------------- }

procedure TProfI.EdIMaterCreate(Sender: TObject);
begin
  EdIMater.Items.Add('Ocel');
  EdIMater.ItemIndex:=0;
end;

procedure TProfI.EdIRozmerCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to PocIPro-1 do EdIRozmer.Items.Add(ProfilI[pocitam].prurez);
end;

procedure TProfI.EdIHmotCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilI[EdIRozmer.ItemIndex].hmota*EdIDelka.Value;
end;

procedure TProfI.EdIPlochaCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilI[EdIRozmer.ItemIndex].povrch*EdIDelka.Value*1000;
end;

procedure TProfI.EdIChange(Sender: TObject);
begin
  EdIHmot.Recompute;
  EdIPlocha.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TProfI.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

