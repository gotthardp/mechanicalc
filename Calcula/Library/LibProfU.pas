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
unit LibProfU;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes;

type
  TProfU = class(TCommonForm)
    LaUMater: TLabel;
    LaURozmer: TLabel;
    LaUDelka: TLabel;
    EdUMater: TClrComboBox;
    EdURozmer: TClrComboBox;
    EdUDelka: TsiEdit;
    ScrU: TScrollBox;
    LaUHmot: TLabel;
    LaUPlocha: TLabel;
    EdUPlocha: TsiComboEdit;
    EdUHmot: TsiComboEdit;
    procedure EdUMaterCreate(Sender: TObject);
    procedure EdURozmerCreate(Sender: TObject);
    procedure EdUHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdUPlochaCompute(Sender: TObject; var Value: Extended);
    procedure EdUChange(Sender: TObject);

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

const {staticke parametry U profilu}
      PocUPro=14;
      ProfilU:array[0..PocUPro-1] of record
                prurez:string;
                hmota:single; {hmotnosti v kg/m}
                povrch:single; {plocha v m2 na metr}
              end=((prurez:'50'; hmota:5.59; povrch:0.23),
                   (prurez:'65'; hmota:7.09; povrch:0.27),
                   (prurez:'80'; hmota:8.65; povrch:0.31),
                   (prurez:'100'; hmota:10.6; povrch:0.37),
                   (prurez:'120'; hmota:13.3; povrch:0.43),
                   (prurez:'140'; hmota:16.0; povrch:0.49),
                   (prurez:'160'; hmota:18.9; povrch:0.54),
                   (prurez:'180'; hmota:22.0; povrch:0.60),
                   (prurez:'200'; hmota:25.3; povrch:0.66),
                   (prurez:'220'; hmota:29.4; povrch:0.72),
                   (prurez:'240'; hmota:33.2; povrch:0.78),
                   (prurez:'260'; hmota:37.9; povrch:0.83),
                   (prurez:'280'; hmota:41.9; povrch:0.89),
                   (prurez:'300'; hmota:46.1; povrch:0.95));

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\U';
  Result.Trida := TProfU.Create( AOwner );
end;

{ --- U profil -------------------------------------------------------------- }

procedure TProfU.EdUMaterCreate(Sender: TObject);
begin
  EdUMater.Items.Add('Ocel');
  EdUMater.ItemIndex:=0;
end;

procedure TProfU.EdURozmerCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to PocUPro-1 do EdURozmer.Items.Add(ProfilU[pocitam].prurez);
end;

procedure TProfU.EdUHmotCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilU[EdURozmer.ItemIndex].hmota*EdUDelka.Value;
end;

procedure TProfU.EdUPlochaCompute(Sender: TObject; var Value: Extended);
begin
  Value:=ProfilU[EdURozmer.ItemIndex].povrch*EdUDelka.Value*1000;
end;

procedure TProfU.EdUChange(Sender: TObject);
begin
  EdUHmot.Recompute;
  EdUPlocha.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TProfU.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

