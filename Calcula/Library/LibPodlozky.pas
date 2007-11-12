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
unit LibPodlozky;

interface

uses
  LibCommon, rxToolEdit, siEdit, Forms, StdCtrls, Mask, Controls, ClrListBox,
  Classes, Graphics;

type
  TPodlozky = class(TCommonForm)
    LaPodNorm: TLabel;
    LaPodRoz: TLabel;
    LaPodKus: TLabel;
    EdPodNorm: TClrComboBox;
    EdPodRoz: TClrComboBox;
    EdPodKus: TsiEdit;
    ScrPod: TScrollBox;
    LaPodHmot: TLabel;
    EdPodHmot: TsiComboEdit;
    procedure EdPodNormCreate(Sender: TObject);
    procedure EdPodRozCreate(Sender: TObject);
    procedure EdPodRozColorItem(Control: TWinControl; Index: Integer;
      var Color: TColor);
    procedure PodlozkaNormChange(Sender: TObject);
    procedure EdPodHmotCompute(Sender: TObject; var Value: Extended);
    procedure EdPodChange(Sender: TObject);

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

const
      {normy podložek}
      PodNormP=1;
      PodNorm: array[0..PodNormP-1] of string =
                   ( 'ÈSN 02 1702' );
      {hmotnosti podložek v gramech}
      PodHmotP=50;
      PodHmot: array[0..PodHmotP-1] of record
                  dira:string;
                  hmota: array[0..PodNormP-1] of single;
               End=((dira:'1,7'; hmota: (0.024) ),
                    (dira:'2,2'; hmota: (0.037) ),
                    (dira:'2,7'; hmota: (0.108) ),
                    (dira:'3,2'; hmota: (0.119) ),
                    (dira:'3,7'; hmota: (0.131) ),
                    (dira:'4,3'; hmota: (0.308) ),
                    (dira:'5,3'; hmota: (0.443) ),
                    (dira:'6,4'; hmota: (1.14) ),
                    (dira:'7,4'; hmota: (1.39) ),
                    (dira:'8,4'; hmota: (2.15) ),
                    (dira:'10,5'; hmota: (4.08) ),
                    (dira:'13'; hmota: (6.27) ),
                    (dira:'15'; hmota: (8.61) ),
                    (dira:'17'; hmota: (11.3) ),
                    (dira:'19'; hmota: (14.7) ),
                    (dira:'21'; hmota: (17.2) ),
                    (dira:'23'; hmota: (18.3) ),
                    (dira:'25'; hmota: (32.3) ),
                    (dira:'26'; hmota: (31.1) ),
                    (dira:'28'; hmota: (42.3) ),
                    (dira:'29'; hmota: (40.9) ),
                    (dira:'31'; hmota: (53.6) ),
                    (dira:'33'; hmota: (64.7) ),
                    (dira:'34'; hmota: (75.3) ),
                    (dira:'37'; hmota: (92.1) ),
                    (dira:'40'; hmota: (133) ),
                    (dira:'41'; hmota: (130) ),
                    (dira:'43'; hmota: (183) ),
                    (dira:'46'; hmota: (220) ),
                    (dira:'50'; hmota: (294) ),
                    (dira:'52'; hmota: (284) ),
                    (dira:'54'; hmota: (330) ),
                    (dira:'58'; hmota: (425) ),
                    (dira:'62'; hmota: (458) ),
                    (dira:'65'; hmota: (437) ),
                    (dira:'66'; hmota: (492) ),
                    (dira:'70'; hmota: (586) ),
                    (dira:'72'; hmota: (568) ),
                    (dira:'74'; hmota: (626) ),
                    (dira:'78'; hmota: (748) ),
                    (dira:'82'; hmota: (953) ),
                    (dira:'93'; hmota: (1254) ),
                    (dira:'104'; hmota: (1709) ),
                    (dira:'114'; hmota: (1831) ),
                    (dira:'124'; hmota: (2832) ),
                    (dira:'129'; hmota: (3131) ),
                    (dira:'134'; hmota: (3445) ),
                    (dira:'144'; hmota: (4089) ),
                    (dira:'155'; hmota: (4268) ),
                    (dira:'165'; hmota: (4770) ) );

function RegisterPage(AOwner: TComponent): TVypocty;
begin
  Result.Name := 'Hmotnosti\Podložky';
  Result.Trida := TPodlozky.Create( AOwner );
end;

{ --- Podložky -------------------------------------------------------------- }

procedure TPodlozky.EdPodNormCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to PodNormP-1 do EdPodNorm.Items.Add(PodNorm[pocitam]);
end;

procedure TPodlozky.EdPodRozCreate(Sender: TObject);
var pocitam:integer;
begin
  for pocitam:=0 to PodHmotP-1 do EdPodRoz.Items.Add(PodHmot[Pocitam].Dira);
end;

procedure TPodlozky.EdPodRozColorItem(Control: TWinControl; Index: Integer;
  var Color: TColor);
begin
  try
    If PodHmot[Index].hmota[EdPodNorm.ItemIndex] > 0
      then Color:=clBlack else Color:=clSilver;
  except
  end;
end;

procedure TPodlozky.PodlozkaNormChange(Sender: TObject);
begin
  EdPodRoz.Invalidate;
  EdPodHmot.Recompute;
end;

procedure TPodlozky.EdPodHmotCompute(Sender: TObject; var Value: Extended);
var Kusu:double;
    Vysledek:Extended; { hmotnost v gramech }
begin
  Kusu:=Ceil(EdPodKus.Value);  {zokrouhlí nahoru}
  if Kusu<0 then raise EMathError.Create('Poèet kusù je záporný');

  Vysledek:=PodHmot[EdPodRoz.ItemIndex].hmota[EdPodNorm.ItemIndex];
  If Vysledek=0 then raise EMathError.Create('Požadovaná podložka není v normì');

  Value:=Vysledek*Kusu/1000; { hmotnost v kilogramech }
end;

procedure TPodlozky.EdPodChange(Sender: TObject);
begin
  EdPodHmot.Recompute;
end;

{ --------------------------------------------------------------------------- }

procedure TPodlozky.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

end.

