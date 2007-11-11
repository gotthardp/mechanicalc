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
unit LibSestihran;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes, Graphics;

type
  TSestihran = class(TCommonForm)
    LaSeMater: TLabel;
    LaSeSirka: TLabel;
    LaSeDelka: TLabel;
    EdSeMater: TClrComboBox;
    EdSeSirka: TsiEdit;
    EdSeDelka: TsiEdit;
    ScrSe: TScrollBox;
    LaSeHmot: TLabel;
    LaSeOhyb: TLabel;
    LaSeSetr: TLabel;
    EdSeHmot: TsiComboEdit;
    EdSeOhyb: TsiComboEdit;
    EdSeSetr: TsiComboEdit;
    procedure EdSeMaterCreate(Sender: TObject);
    procedure EdSeMaterColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure EdSeHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdSeOhybCompute(Sender: TObject; var Value: Extended);
    procedure EdSeSetrCompute(Sender: TObject; var Value: Extended);
    procedure EdSeChange(Sender: TObject);

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
  Result.Name := 'Hmotnosti\Šestihran';
  Result.Trida := TSestihran.Create( AOwner );
end;

{ --- Šestihran ------------------------------------------------------------- }

procedure TSestihran.EdSeMaterCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to Latek-1 do begin
    EdSeMater.Items.Add(Latky[pocitam].nazev);
  end;
end;

procedure TSestihran.EdSeMaterColorItem(Control: TWinControl;
  Index: Integer; var Color: TColor);
begin
  If Latky[Index].hustota > 0 then Color:=clBlack else Color:=clSilver;
end;

procedure TSestihran.EdSeHmotCompute(Sender: TObject; var Value: Extended);
var Hustota:double;
begin
  Hustota:=Latky[EdSeMater.ItemIndex].hustota;
  Value:=hustota*sqrt(3)*Power(EdSeSirka.Value,2)/2*EdSeDelka.Value;
end;

procedure TSestihran.EdSeOhybCompute(Sender: TObject; var Value: Extended);
begin
  { tabulkový výpoèet používá polomìr opsané kružnice, uživatel zadal šíøku }
  { r = sirka / sqrt(3) }

  { Wo = 0.5413 * r^3 }
  Value:=0.5413*Power(EdSeSirka.Value/sqrt(3),3);
end;

procedure TSestihran.EdSeSetrCompute(Sender: TObject; var Value: Extended);
begin
  { tabulkový výpoèet používá polomìr opsané kružnice, uživatel zadal šíøku }
  { r = sirka / sqrt(3) }

  { Ix = 0.5413 * r^4 }
  Value:=0.5413*Power(EdSeSirka.Value,4)/9;
end;

procedure TSestihran.EdSeChange(Sender: TObject);
begin
  EdSeHmot.Recompute;
  EdSeOhyb.Recompute;
  EdSeSetr.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TSestihran.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

