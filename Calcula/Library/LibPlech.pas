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
unit LibPlech;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes, Graphics;

Const Nazev='Strojírenský kalkulátor';
      Chybka='Chyba';
      Hmota='Hmotnost ';
type
  TPlech = class(TCommonForm)
    LaPlMater: TLabel;
    LaPlPlocha: TLabel;
    LaPlTloustka: TLabel;
    EdPlMater: TClrComboBox;
    EdPlPlocha: TsiEdit;
    EdPlTloustka: TsiEdit;
    ScrPl: TScrollBox;
    LaPlHmot: TLabel;
    EdPlHmot: TsiComboEdit;
    procedure EdPlMaterCreate(Sender: TObject);
    procedure EdPlMaterColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure EdPlHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdPlChange(Sender: TObject);

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
  Math;

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\Plech';
  Result.Trida := TPlech.Create( AOwner );
end;

{ --- Plech ----------------------------------------------------------------- }

procedure TPlech.EdPlMaterCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to Latek-1 do begin
    EdPlMater.Items.Add(Latky[pocitam].nazev);
  end;
end;

procedure TPlech.EdPlMaterColorItem(Control: TWinControl; Index: Integer;
  var Color: TColor);
begin
  If Latky[Index].hustota > 0 then Color:=clBlack else Color:=clSilver;
end;

procedure TPlech.EdPlHmotCompute(Sender: TObject; var Value: Extended);
var Hustota:double;
begin
  Hustota:=Latky[EdPlMater.ItemIndex].hustota;
  Value:=hustota*EdPlTloustka.Value*EdPlPlocha.Value;
end;

procedure TPlech.EdPlChange(Sender: TObject);
begin
  EdPlHmot.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TPlech.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

