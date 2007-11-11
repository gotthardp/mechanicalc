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
unit LibKomoly;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes, Graphics;

type
  TKomoly = class(TCommonForm)
    LaKokMater: TLabel;
    LaKokVelkeD: TLabel;
    LaKokMaleD: TLabel;
    LaKokDelka: TLabel;
    EdKokMater: TClrComboBox;
    EdKokVelkeD: TsiEdit;
    EdKokMaleD: TsiEdit;
    EdKokDelka: TsiEdit;
    ScrKok: TScrollBox;
    LaKokHmot: TLabel;
    EdKokHmot: TsiComboEdit;
    procedure EdKokMaterCreate(Sender: TObject);
    procedure EdKokMaterColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure EdKokHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdKokChange(Sender: TObject);

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

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\Kužel komolý';
  Result.Trida := TKomoly.Create( AOwner );
end;

{ --- Komolý kužel ---------------------------------------------------------- }

procedure TKomoly.EdKokMaterCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to Latek-1 do begin
    EdKokMater.Items.Add(Latky[pocitam].nazev);
  end;
end;

procedure TKomoly.EdKokMaterColorItem(Control: TWinControl; Index: Integer;
  var Color: TColor);
begin
  If Latky[Index].hustota > 0 then Color:=clBlack else Color:=clSilver;
end;

procedure TKomoly.EdKokHmotCompute(Sender: TObject; var Value: Extended);
var Hustota:double;
begin
  Hustota:=Latky[EdKokMater.ItemIndex].hustota;
  Value:=hustota*pi*EdKokDelka.Value*(EdKokMaleD.Value*EdKokMaleD.Value+EdKokMaleD.Value*EdKokVelkeD.Value+EdKokVelkeD.Value*EdKokVelkeD.Value)/12;
end;

procedure TKomoly.EdKokChange(Sender: TObject);
begin
  EdKokHmot.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TKomoly.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

