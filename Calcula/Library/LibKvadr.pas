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
unit LibKvadr;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes, Graphics;

type
  TKvadr = class(TCommonForm)
    LaKvMater: TLabel;
    LaKvVyska: TLabel;
    LaKvSirka: TLabel;
    LaKvDelka: TLabel;
    EdKvMater: TClrComboBox;
    EdKvVyska: TsiEdit;
    EdKvSirka: TsiEdit;
    EdKvDelka: TsiEdit;
    ScrKv: TScrollBox;
    LaKvHmot: TLabel;
    LaKvOhyb: TLabel;
    LaKvSetr: TLabel;
    EdKvOhyb: TsiComboEdit;
    EdKvHmot: TsiComboEdit;
    EdKvSetr: TsiComboEdit;
    procedure EdKvMaterCreate(Sender: TObject);
    procedure EdKvMaterColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure EdKvHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdKvOhybCompute(Sender: TObject; var Value: Extended);
    procedure EdKvSetrCompute(Sender: TObject; var Value: Extended);
    procedure EdKvChange(Sender: TObject);

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
  Result.Name := 'Hmotnosti\Kvádr';
  Result.Trida := TKvadr.Create( AOwner );
end;

{ --- Kvádr ----------------------------------------------------------------- }

procedure TKvadr.EdKvMaterCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to Latek-1 do begin
    EdKvMater.Items.Add(Latky[pocitam].nazev);
  end;
end;

procedure TKvadr.EdKvMaterColorItem(Control: TWinControl; Index: Integer;
  var Color: TColor);
begin
  If Latky[Index].hustota > 0 then Color:=clBlack else Color:=clSilver;
end;

procedure TKvadr.EdKvHmotCompute(Sender: TObject; var Value: Extended);
var Hustota:double;
begin
  Hustota:=Latky[EdKvMater.ItemIndex].hustota;
  Value:=hustota*EdKvVyska.Value*EdKvSirka.Value*EdKvDelka.Value;
end;

procedure TKvadr.EdKvOhybCompute(Sender: TObject; var Value: Extended);
begin
  { Wo = ( b * h^2 ) / 6 }
  Value:=EdKvSirka.Value*Power(EdKvVyska.Value,2)/6;
end;

procedure TKvadr.EdKvSetrCompute(Sender: TObject; var Value: Extended);
begin
  { Ix = ( b * h^3 ) / 12 }
  Value:=EdKvSirka.Value*Power(EdKvVyska.Value,3)/12;
end;

procedure TKvadr.EdKvChange(Sender: TObject);
begin
  EdKvHmot.Recompute;
  EdKvOhyb.Recompute;
  EdKvSetr.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TKvadr.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

