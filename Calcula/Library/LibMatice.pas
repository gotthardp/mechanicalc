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
unit LibMatice;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes, Graphics;

type
  TMatice = class(TCommonForm)
    LaMatNorm: TLabel;
    LaMatZav: TLabel;
    LaMatKus: TLabel;
    EdMatNorm: TClrComboBox;
    EdMatKus: TsiEdit;
    EdMatZav: TClrComboBox;
    ScrMat: TScrollBox;
    LaMatHmot: TLabel;
    EdMatHmot: TsiComboEdit;
    procedure EdMatNormCreate(Sender: TObject);
    procedure EdMatZavCreate(Sender: TObject);
    procedure EdMatZavColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure MaticeNormChange(Sender: TObject);
    procedure EdMatHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdMatChange(Sender: TObject);

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

const {normy matic}
      MatNormP=5;
      MatNorm: array[0..MatNormP-1] of string =
                   ( 'ÈSN 02 1401',
                     'ÈSN 02 1601',
                     'ÈSN 02 1403',
                     'ÈSN 02 1402',
                     'ÈSN 02 1407' );
      {hmotnosti matic v gramech}
      MatHmotP=46;
      MatHmot: array[0..MatHmotP-1] of record
                  zavit:string;
                  hmota: array[0..MatNormP-1] of single;
               End=((zavit:'M1,6';    hmota: (0.065, 0,    0.0485, 0,    0.045) ),
                    (zavit:'M2';      hmota: (0.125, 0,    0.0938, 0,    0.088) ),
                    (zavit:'M2,5';    hmota: (0.252, 0,    0.218,  0,    0.191) ),
                    (zavit:'M3';      hmota: (0.348, 0,    0.232,  0,    0.222) ),
                    (zavit:'M4';      hmota: (0.735, 0,    0.460,  0,    0.447) ),
                    (zavit:'M5';      hmota: (1.13,  1.15, 0.705,  0,    0.693) ),
                    (zavit:'M6';      hmota: (2.35,  2.38, 1.41,   1.49, 1.36) ),
                    (zavit:'M7';      hmota: (0,     0,    0,      2.67, 0) ),
                    (zavit:'M8';      hmota: (4.71,  4.71, 3.93,   3.62, 3.05) ),
                    (zavit:'M8×1';    hmota: (4.63,  0,    3.86,   3.53, 0) ),
                    (zavit:'M10';     hmota: (10.8,  11.2, 8.09,   5.34, 6.85) ),
                    (zavit:'M10×1,25';hmota: (10.6,  0,    8.0,    5.1,  0) ),
                    (zavit:'M12';     hmota: (16.5,  16.8, 11.6,   9.75, 0) ),
                    (zavit:'M12×1,25';hmota: (16.3,  0,    11.2,   9.44, 0) ),
                    (zavit:'M14';     hmota: (24.1,  0,    17.5,   13.5, 0) ),
                    (zavit:'M14×1,5'; hmota: (23.6,  0,    17.2,   13.0, 0) ),
                    (zavit:'M16';     hmota: (33.0,  32.7, 20.3,   21.2, 0) ),
                    (zavit:'M16×1,5'; hmota: (31.5,  0,    19.4,   20.6, 0) ),
                    (zavit:'M18';     hmota: (44.5,  0,    28.7,   27.9, 0) ),
                    (zavit:'M18×1,5'; hmota: (42.6,  0,    27.4,   26.0, 0) ),
                    (zavit:'M20';     hmota: (62.5,  63.3, 35.1,   38.1, 0) ),
                    (zavit:'M20×1,5'; hmota: (60.0,  0,    33.7,   36.0, 0) ),
                    (zavit:'M22';     hmota: (76.0,  74.1, 42.3,   0,    0) ),
                    (zavit:'M22×1,5'; hmota: (73.5,  0,    40.8,   0,    0) ),
                    (zavit:'M24';     hmota: (107,   105,  56.0,   0,    0) ),
                    (zavit:'M24×2';   hmota: (103,   0,    54.3,   0,    0) ),
                    (zavit:'M27';     hmota: (161,   159,  87.9,   0,    0) ),
                    (zavit:'M27×2';   hmota: (157,   0,    85.4,   0,    0) ),
                    (zavit:'M30';     hmota: (225,   219,  118,    0,    0) ),
                    (zavit:'M30×2';   hmota: (218,   0,    109,    0,    0) ),
                    (zavit:'M33';     hmota: (312,   279,  156,    0,    0) ),
                    (zavit:'M33×2';   hmota: (295,   0,    148,    0,    0) ),
                    (zavit:'M36×3';   hmota: (364,   358,  183,    0,    0) ),
                    (zavit:'M39×3';   hmota: (485,   479,  251,    0,    0) ),
                    (zavit:'M42×3';   hmota: (590,   585,  295,    0,    0) ),
                    (zavit:'M45×3';   hmota: (750,   745,  386,    0,    0) ),
                    (zavit:'M48×3';   hmota: (935,   928,  443,    0,    0) ),
                    (zavit:'M52×3';   hmota: (1115,  1104, 557,    0,    0) ),
                    (zavit:'M56×4';   hmota: (1370,  1355, 0,      0,    0) ),
                    (zavit:'M60×4';   hmota: (1640,  1625, 0,      0,    0) ),
                    (zavit:'M64×4';   hmota: (1830,  1840, 0,      0,    0) ),
                    (zavit:'M68×4';   hmota: (2140,  0,    0,      0,    0) ),
                    (zavit:'M72×4';   hmota: (2430,  2430, 0,      0,    0) ),
                    (zavit:'M76×4';   hmota: (2880,  0,    0,      0,    0) ),
                    (zavit:'M80×4';   hmota: (3220,  3190, 0,      0,    0) ),
                    (zavit:'M90×4';   hmota: (4540,  4640, 0,      0,    0) ) );

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\Matice';
  Result.Trida := TMatice.Create( AOwner );
end;

{ --- Matice ---------------------------------------------------------------- }

procedure TMatice.EdMatNormCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to MatNormP-1 do EdMatNorm.Items.Add(MatNorm[pocitam]);
end;

procedure TMatice.EdMatZavCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to MatHmotP-1 do EdMatZav.Items.Add(MatHmot[Pocitam].Zavit);
end;

procedure TMatice.EdMatZavColorItem(Control: TWinControl; Index: Integer;
  var Color: TColor);
begin
  try
    If MatHmot[Index].hmota[EdMatNorm.ItemIndex] > 0
      then Color := clBlack else Color := clSilver;
  except
  end;
end;

procedure TMatice.MaticeNormChange(Sender: TObject);
begin
  EdMatZav.Invalidate;
  EdMatHmot.Recompute;
end;

procedure TMatice.EdMatHmotCompute(Sender: TObject; var Value: Extended);
var Kusu:double;
    Vysledek:Extended; { hmotnost v gramech }
begin
  Kusu:=Ceil(EdMatKus.Value);  {zokrouhlí nahoru}
  if Kusu<0 then raise EMathError.Create('Poèet kusù je záporný');

  Vysledek:=MatHmot[EdMatZav.ItemIndex].hmota[EdMatNorm.ItemIndex];
  If Vysledek=0 then raise EMathError.Create('Požadovaná matice není v normì');

  Value:=Vysledek*Kusu/1000; { hmotnost v kilogramech }
end;

procedure TMatice.EdMatChange(Sender: TObject);
begin
  EdMatHmot.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TMatice.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

