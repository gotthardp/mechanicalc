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
unit LibValec;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, Controls, StdCtrls, ClrListBox, Mask,
  Classes, Graphics;

type
  TValec = class(TCommonForm)
    LaVaPrumer: TLabel;
    LaVaDelka: TLabel;
    LaVaMater: TLabel;
    EdVaPrumer: TsiEdit;
    EdVaDelka: TsiEdit;
    EdVaMater: TClrComboBox;
    ScrVa: TScrollBox;
    LaVaHmot: TLabel;
    LaVaOhyb: TLabel;
    LaVaSetr: TLabel;
    EdVaOhyb: TsiComboEdit;
    EdVaHmot: TsiComboEdit;
    EdVaSetr: TsiComboEdit;
    procedure EdVaMaterCreate(Sender: TObject);
    procedure EdVaMaterColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure EdVaHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdVaOhybCompute(Sender: TObject; var Value: Extended);
    procedure EdVaSetrCompute(Sender: TObject; var Value: Extended);
    procedure EdVaChange(Sender: TObject);

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
  Result.Name := 'Hmotnosti\Válec';
  Result.Trida := TValec.Create( AOwner );
end;

{ --- Válec ----------------------------------------------------------------- }

procedure TValec.EdVaMaterCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to Latek-1 do begin
    EdVaMater.Items.Add(Latky[pocitam].nazev);
  end;
end;

procedure TValec.EdVaMaterColorItem(Control: TWinControl; Index: Integer;
  var Color: TColor);
begin
  If Latky[Index].hustota > 0 then Color:=clBlack else Color:=clSilver;
end;

procedure TValec.EdVaHmotCompute(Sender: TObject; var Value: Extended);
var Hustota:double;
begin
  Hustota:=Latky[EdVaMater.ItemIndex].hustota;
  Value:=hustota*EdVaDelka.Value*(pi*Power(EdVaPrumer.Value,2)/4);
end;

procedure TValec.EdVaOhybCompute(Sender: TObject; var Value: Extended);
begin
  { Wo = pi * d^3 / 32 }
  Value:=pi*Power(EdVaPrumer.Value,3)/32;
end;

procedure TValec.EdVaSetrCompute(Sender: TObject; var Value: Extended);
begin
  { Ix = pi * d^4 / 64 }
  Value:=pi*Power(EdVaPrumer.Value,4)/64;
end;

procedure TValec.EdVaChange(Sender: TObject);
begin
  EdVaHmot.Recompute;
  EdVaOhyb.Recompute;
  EdVaSetr.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TValec.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

