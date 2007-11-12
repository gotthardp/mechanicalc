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
unit LibKroutici;

interface

uses
  LibCommon, Controls, StdCtrls, Mask, rxToolEdit, siEdit, Classes;

type
  TKroutici = class(TCommonForm)
    LaKrVykon: TLabel;
    LaKrMoment: TLabel;
    LaKrOtacky: TLabel;
    EdKrVykon: TsiComboEdit;
    EdKrMoment: TsiComboEdit;
    EdKrOtacky: TsiComboEdit;
    VzKrou: TLabel;
    procedure EdKrVykonCompute(Sender: TObject; var Value: Extended);
    procedure KrVykon(Sender: TObject);
    procedure EdKrMomentCompute(Sender: TObject; var Value: Extended);
    procedure KrMoment(Sender: TObject);
    procedure EdKrOtackyCompute(Sender: TObject; var Value: Extended);
    procedure KrOtacky(Sender: TObject);

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
  Windows;

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Pøevody\Kroutící moment';
  Result.Trida := TKroutici.Create( AOwner );
end;

{ --- Pøevody --------------------------------------------------------------- }

procedure TKroutici.EdKrVykonCompute(Sender: TObject; var Value: Extended);
begin
  try
    Value:=EdKrMoment.Value*2*Pi*EdKrOtacky.Value;
  except
    MessageBeep(MB_ICONEXCLAMATION);
    Value:=0;
  end;
end;

procedure TKroutici.KrVykon(Sender: TObject);
begin
  EdKrVykon.Recompute;
end;

procedure TKroutici.EdKrMomentCompute(Sender: TObject; var Value: Extended);
begin
  try
    Value:=EdKrVykon.Value/(2*Pi*EdKrOtacky.Value);
  except
    MessageBeep(MB_ICONEXCLAMATION);
    Value:=0;
  end;
end;

procedure TKroutici.KrMoment(Sender: TObject);
begin
  EdKrMoment.Recompute;
end;

procedure TKroutici.EdKrOtackyCompute(Sender: TObject; var Value: Extended);
begin
  try
    Value:=EdKrVykon.Value/(2*Pi*EdkrMoment.Value);
  except
    MessageBeep(MB_ICONEXCLAMATION);
    Value:=0;
  end;
end;

procedure TKroutici.KrOtacky(Sender: TObject);
begin
  EdKrOtacky.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TKroutici.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

