{
    Zdrojový kód Strojírenského kalkulátoru

    Copyright (c) 1997-2007  Petr Gotthard
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
unit MainForm;

interface

uses
  LibCommon, rxMrgMngr, ImgList, Controls, ExtCtrls, ComCtrls, StdCtrls,
  Mask, siEdit, Classes, Forms, Messages;

Const Nazev='Strojírenský kalkulátor';

type
  TCalcMain = class(TForm)
    EdZadani: TsiEdit;
    LaRovno: TLabel;
    LiVyber: TTreeView;
    Small: TImageList;
    EdVysledek: TsiEdit;
    paMerge: TPanel;
    MergeMan: TMergeManager;
    procedure FormCreate(Sender: TObject);
    procedure EdButtonClick(Sender: TObject);
    procedure EdVysledekCompute(Sender: TObject; var Value: Extended);
    procedure EdZadaniChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LiVyberChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
  protected
    procedure WndProc(var Message: TMessage); override;
  private
    procedure InsertToManager(Page: TVypocty);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var CalcMain: TCalcMain;

implementation

uses
  Variants, Registry, Windows, ComObj, SysUtils,
  LibProfI, LibProfLr, LibProfLn, LibProfU,
  LibSrouby, LibMatice, LibPodlozky,
  LibCtverec, LibObdelnik, LibKuzel, LibKomoly, LibKvadr, LibPlech,
  LibSestihran, LibTrubka, LibValec,
  LibProdlouzeni, LibKroutici,
  AboutBox;

{$R *.DFM}

const SC_ABOUT = 300;

{ --- Konstrukce ------------------------------------------------------------ }

function AddFind( Where: TTreeView; What: string; Parent:TTreeNode ): TTreeNode;
var i:integer;
    oukej:boolean;
begin
  result := nil;
  oukej := false;
  i := 0;
  while( i < Where.Items.Count ) and ( not oukej ) do begin
    if( Where.Items[i].Text = What ) and ( Where.Items[i].Parent = Parent ) then begin
      Result := Where.Items[i];
      oukej := true;
    end;
    inc( i );
  end;
  if( not oukej ) then begin
    if Parent <> nil then Result := Where.Items.AddChild( Parent, What )
    else Result := Where.Items.Add( Parent, What );

    Result.ImageIndex := 0;
    Result.SelectedIndex := 1;
  end;
end;

constructor TCalcMain.Create(AOwner: TComponent);
var SysMenu:HMenu;
begin
  inherited Create( AOwner );
  // inicializace spolupráce s AutoCADem
  try
    siEdit.AutoCad := GetActiveOleObject('Autocad.Application');
  except
    siEdit.AutoCad := UnAssigned;
  end;
  // inicializace spolupráce s Microsoft Excelem
  try
    siEdit.MSExcel := GetActiveOleObject('Excel.Application');
  except
    siEdit.MSExcel := UnAssigned;
  end;
  // inicializace spolupráce s Microsoft Wordem
  try
    siEdit.MSWord := GetActiveOleObject('Word.Application');
  except
    siEdit.MSWord := UnAssigned;
  end;

  SysMenu:=GetSystemMenu(Handle,false);
  InsertMenu(SysMenu,0,MF_BYPOSITION+MF_STRING,SC_ABOUT,'O programu...');
end;

procedure TCalcMain.FormCreate(Sender: TObject);
var pocitam:integer;
    registry:TRegistry;
    data:PChar;
begin
  if not(csDesigning in ComponentState) then
  begin

    InsertToManager(LibProfI.RegisterPage(self));
    InsertToManager(LibProfLr.RegisterPage(self));
    InsertToManager(LibProfLn.RegisterPage(self));
    InsertToManager(LibProfU.RegisterPage(self));

    InsertToManager(LibSrouby.RegisterPage(self));
    InsertToManager(LibMatice.RegisterPage(self));
    InsertToManager(LibPodlozky.RegisterPage(self));

    InsertToManager(LibCtverec.RegisterPage(self));
    InsertToManager(LibObdelnik.RegisterPage(self));
    InsertToManager(LibKuzel.RegisterPage(self));
    InsertToManager(LibKomoly.RegisterPage(self));
    InsertToManager(LibKvadr.RegisterPage(self));
    InsertToManager(LibPlech.RegisterPage(self));
    InsertToManager(LibSestihran.RegisterPage(self));
    InsertToManager(LibTrubka.RegisterPage(self));
    InsertToManager(LibValec.RegisterPage(self));

    InsertToManager(LibProdlouzeni.RegisterPage(self));
    InsertToManager(LibKroutici.RegisterPage(self));

    registry := TRegistry.Create;
    with registry do
    try
      OpenKey('Software\Gotthard\'+Application.Name,true);

      data:=AllocMem(LiVyber.Items.Count);
      ReadBinaryData('Expanded',data^,LiVyber.Items.Count);

      for pocitam:=0 to LiVyber.Items.Count-1 do
        if data[pocitam]='1' then LiVyber.Items[pocitam].Expanded:=true else LiVyber.Items[pocitam].Expanded:=false;
      FreeMem(data);

      LiVyber.TopItem:=LiVyber.Items[ReadInteger('TopItem')];
      LiVyber.Selected:=LiVyber.Items[ReadInteger('Selected')];

      {poloha okna}
      Top:=ReadInteger('Top');
      Left:=ReadInteger('Left');
    except
      {nìkteré nezbytné implicitní hodnoty}
      LiVyber.TopItem:=LiVyber.Items[0];
      LiVyber.Selected:=LiVyber.Items[0];
    end;
    registry.Destroy;
  end;
end;

procedure TCalcMain.InsertToManager(Page: TVypocty);
var poziend: integer;
    celek: string;
    Parent: TTreeNode;
begin
  celek := Page.Name;
  poziend := pos( '\', celek );
  Parent := nil;
  while poziend > 0 do begin
    Parent := AddFind( LiVyber, copy( celek, 0, poziend-1 ), Parent );
    delete( celek, 1, poziend );
    poziend := pos( '\', celek );
  end;
  Parent := LiVyber.Items.AddChild( Parent, celek );
  Parent.ImageIndex := 2;
  Parent.SelectedIndex := 2;
  Parent.Data := Page.Trida;

  MergeMan.Merge( Page.Trida, false );
end;

{ --- Destrukce ------------------------------------------------------------- }

procedure TCalcMain.FormDestroy(Sender: TObject);
var pocitam:integer;
    registry:TRegistry;
    data:PChar;
begin
  if not(csDesigning in ComponentState) then begin
    registry := TRegistry.Create;
    with registry do
    try
      OpenKey('Software\Gotthard\'+Application.Name,true);

      data:=AllocMem(LiVyber.Items.Count);
      for pocitam:=0 to LiVyber.Items.Count-1 do
        if LiVyber.Items[pocitam].Expanded then data[pocitam]:='1' else data[pocitam]:='0';
      WriteBinaryData('Expanded',data^,LiVyber.Items.Count);
      FreeMem(data);

      WriteInteger('TopItem',LiVyber.TopItem.AbsoluteIndex);
      WriteInteger('Selected',LiVyber.Selected.AbsoluteIndex);
      {poloha okna}
      WriteInteger('Top',Top);
      WriteInteger('Left',Left);
    except
    end;
    registry.Destroy;
  end;

end;

procedure TCalcMain.EdButtonClick(Sender: TObject);
begin
  EdZadani.Text := EdZadani.Text + (Sender as TsiComboEdit).Text;
end;

procedure TCalcMain.EdVysledekCompute(Sender: TObject; var Value: Extended);
begin
  Value := EdZadani.Value;
end;

procedure TCalcMain.EdZadaniChange(Sender: TObject);
begin
  EdVysledek.Recompute;
end;

procedure TCalcMain.WndProc(var Message: TMessage);
begin  { tests to determine whether to continue processing }
  if( Message.msg = WM_SYSCOMMAND ) and ( Message.wparam = SC_ABOUT ) then begin
    ShowAboutBox;
  end;
  inherited WndProc(Message);	{ dispatch normally }end;

procedure TCalcMain.LiVyberChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);

var trida:TCommonForm;
begin
  if( LiVyber.Selected <> nil ) then begin
    trida := LiVyber.Selected.Data;
    if trida <> nil then begin
      trida.Visible := false;
      Caption := Nazev;
    end;
  end;
  if( Node <> nil ) then begin
    trida := Node.Data;
    if trida <> nil then begin
      MergeMan.GotoForm( Node.Data );
      trida.Visible := true;
      Caption := Nazev + ' - [ ' + trida.Caption  + ' ]';
    end;
  end;
  AllowChange := true;
end;

end.

