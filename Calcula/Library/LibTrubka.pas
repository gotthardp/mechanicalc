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
unit LibTrubka;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes, Graphics;

type
  TTrubka = class(TCommonForm)
    LaTrMater: TLabel;
    LaTrPrumer: TLabel;
    LaTrTloustka: TLabel;
    LaTrDelka: TLabel;
    EdTrMater: TClrComboBox;
    EdTrPrumer: TsiEdit;
    EdTrTloustka: TsiEdit;
    EdTrDelka: TsiEdit;
    ScrTr: TScrollBox;
    LaTrHmot: TLabel;
    LaTrOhyb: TLabel;
    LaTrSetr: TLabel;
    EdTrOhyb: TsiComboEdit;
    EdTrHmot: TsiComboEdit;
    EdTrSetr: TsiComboEdit;
    procedure EdTrMaterCreate(Sender: TObject);
    procedure EdTrMaterColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure EdTrHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdTrOhybCompute(Sender: TObject; var Value: Extended);
    procedure EdTrSetrCompute(Sender: TObject; var Value: Extended);
    procedure EdTrChange(Sender: TObject);

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
  Result.Name := 'Hmotnosti\Trubka';
  Result.Trida := TTrubka.Create( AOwner );
end;

{ --- Trubka ---------------------------------------------------------------- }

procedure TTrubka.EdTrMaterCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to Latek-1 do begin
    EdTrMater.Items.Add(Latky[pocitam].nazev);
  end;
end;

procedure TTrubka.EdTrMaterColorItem(Control: TWinControl; Index: Integer;
  var Color: TColor);
begin
  If Latky[Index].hustota > 0 then Color:=clBlack else Color:=clSilver;
end;

procedure TTrubka.EdTrHmotCompute(Sender: TObject; var Value: Extended);
var Hustota:double;
begin
  If EdTrPrumer.Value < 2*EdTrTloustka.Value then raise EMathError.Create('Prùmìr je menší než tlouška');
  Hustota:=Latky[EdTrMater.ItemIndex].hustota;
  Value:=hustota*EdTrDelka.Value*pi*(Power(EdTrPrumer.Value,2)-Power(EdTrPrumer.Value-2*EdTrTloustka.Value,2))/4;
end;

procedure TTrubka.EdTrOhybCompute(Sender: TObject; var Value: Extended);
begin
  If EdTrPrumer.Value < 2*EdTrTloustka.Value then raise EMathError.Create('Prùmìr je menší než tlouška');
  { Wo = pi * ( D^4 - d^4 ) / ( 32 * D ) }
  Value:=(pi*(Power(EdTrPrumer.Value,4)-Power(EdTrPrumer.Value-2*EdTrTloustka.Value,4)))/(32*EdTrPrumer.Value);
end;

procedure TTrubka.EdTrSetrCompute(Sender: TObject; var Value: Extended);
begin
  If EdTrPrumer.Value < 2*EdTrTloustka.Value then raise EMathError.Create('Prùmìr je menší než tlouška');
  { Ix = pi * ( D^4 - d^4 ) / 64 }
  Value:=pi*(Power(EdTrPrumer.Value,4)-Power(EdTrPrumer.Value-2*EdTrTloustka.Value,4))/64;
end;

procedure TTrubka.EdTrChange(Sender: TObject);
begin
  EdTrHmot.Recompute;
  EdTrOhyb.Recompute;
  EdTrSetr.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TTrubka.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

