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
unit LibProdlouzeni;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes, Graphics;

type
  TProdlouzeni = class(TCommonForm)
    LaProdMat: TLabel;
    LaProdDelka: TLabel;
    LaProdRozdil: TLabel;
    EdProdMat: TClrComboBox;
    EdProdDelka: TsiEdit;
    EdProdRozdil: TsiEdit;
    ScrProd: TScrollBox;
    LaProdProd: TLabel;
    EdProdProd: TsiComboEdit;
    procedure EdProdMatCreate(Sender: TObject);
    procedure EdProdMatColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure EdProdProdCompute(Sender: TObject; var Value: Extended);
    procedure EdProdChange(Sender: TObject);

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
  Math, SysUtils;

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Výpoèty\Prodloužení';
  Result.Trida := TProdlouzeni.Create( AOwner );
end;

{ --- Prodloužení ----------------------------------------------------------- }

procedure TProdlouzeni.EdProdMatCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to Latek-1 do begin
    EdProdMat.Items.Add(Latky[pocitam].nazev);
  end;
end;

procedure TProdlouzeni.EdProdMatColorItem(Control: TWinControl;
  Index: Integer; var Color: TColor);
begin
  If Latky[Index].roztah > 0 then Color:=clBlack else Color:=clSilver;
end;

procedure TProdlouzeni.EdProdProdCompute(Sender: TObject; var Value: Extended);
var Koefic:Extended;
begin
  Koefic:=Latky[EdProdMat.ItemIndex].roztah*1e-6;
  If Koefic=0 then raise EMathError.Create('Požadovaný materiál není v tabulkách');

  { dL = L * alpha * dT }
  Value:=EdProdDelka.Value*Koefic*EdProdRozdil.Value;
end;

procedure TProdlouzeni.EdProdChange(Sender: TObject);
begin
  EdProdProd.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TProdlouzeni.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

