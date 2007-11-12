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
unit LibKuzel;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, Controls, StdCtrls, ClrListBox, Mask,
  Classes, Graphics;

type
  TKuzel = class(TCommonForm)
    LaKuDelka: TLabel;
    LaKuPrumer: TLabel;
    LaKuMater: TLabel;
    EdKuPrumer: TsiEdit;
    EdKuDelka: TsiEdit;
    EdKuMater: TClrComboBox;
    ScrKu: TScrollBox;
    LaKuHmot: TLabel;
    EdKuHmot: TsiComboEdit;
    procedure EdKuMaterCreate(Sender: TObject);
    procedure EdKuMaterColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure EdKuHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdKuChange(Sender: TObject);

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
  Result.Name := 'Hmotnosti\Kužel';
  Result.Trida := TKuzel.Create( AOwner );
end;

{ --- Kužel ----------------------------------------------------------------- }

procedure TKuzel.EdKuMaterCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to Latek-1 do begin
    EdKuMater.Items.Add(Latky[pocitam].nazev);
  end;
end;

procedure TKuzel.EdKuMaterColorItem(Control: TWinControl; Index: Integer;
  var Color: TColor);
begin
  If Latky[Index].hustota > 0 then Color:=clBlack else Color:=clSilver;
end;

procedure TKuzel.EdKuHmotCompute(Sender: TObject; var Value: Extended);
var Hustota:double;
begin
  Hustota:=Latky[EdKuMater.ItemIndex].hustota;
  Value:=hustota*pi*EdKuDelka.Value*Power(EdKuPrumer.Value,2)/12;
end;

procedure TKuzel.EdKuChange(Sender: TObject);
begin
  EdKuHmot.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TKuzel.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

