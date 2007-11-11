{
    Zdrojov˝ kÛd StrojÌrenskÈho kalkul·toru

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

    $Id: AnyBnfFile.cpp 22 2007-09-26 17:51:41Z gotthardp $
}

{$B-}
unit siEdit;

interface

uses
  Classes, Messages, Mask, Graphics, Controls, StdCtrls, Menus,
  rxToolEdit, siEditParser, siEditProperties;

{$R *.RES}

type TUnits = (UN_none, UN_m, UN_m2, UN_m3, UN_m4, UN_W, UN_N, UN_Nm, UN_s, UN_1s, UN_kg);
     TMeasure = ( meNone, meDistance );
     TOptions = set of ( RoundItem, SaveState );

     TComputeEvent = procedure (Sender: TObject; var Value:Extended) of object;

     TsiEdit = class( TCustomMaskEdit )
     private
       FActual:Byte;         {relativni poradi aktualni jednotky}
       FCaption:String;      {n·zev, pÌöe se p¯ed jednotku}
       FColorOK:TColor;      {pozadÌ}
       FColorError:TColor;   {pozadÌ p¯i chybÏ}
       FError:string;        {popis chyby, '' = nenÌ chyba}
       FHintOK:string;       {n·povÏda}
       FHelpProperties:integer;
       FLabel:TLabel;        {sprateleny label pro zobrazeni jednotky}
       FMenu:TPopupMenu;     {odkazy na menu}
       FUnitMenu:TMenuItem;
       FParser:TMathParser;  {odkaz na vypocetni system}
       FMeasure: TMeasure;   {druh omÏ¯ov·nÌ AutoCADem}
       FOptions:TOptions;
       FRound:TRound;        {nastaveni zaokrouhlovani vysledku}
       FRoundUser:shortint;  {uzivatelske zaokrouhlovani vysledku}
       FUnits:TUnits;        {druh jednotky}
       FUnitOffset:Byte;     {absolutni poradi prvni jednotky}

       FLabelChange:TNotifyEvent; {zmenila se jednotka}
       FCompute:TComputeEvent;    {vypocet hodnoty}

       procedure OnItemClick(Sender:TObject);
       procedure OnPopup(Sender:TObject);

       procedure SetActual(Data:Byte);
       procedure SetError(Data:string);
       procedure SetHintOK(Data:string);
       procedure SetUnits(Data:TUnits);
       procedure SetValue(Data:Extended);
       function GetValue:Extended;

       function NewMItem(Caption,Name:string;Checked:boolean;ImIndex:integer;Short:TShortCut):TMenuItem;
       procedure WMdestroy(var Message: TMessage); message WM_DESTROY;
     protected
       procedure CreateWnd; override;
       procedure DestroyWnd; override;
     public
       { Public declarations }
       constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
       procedure Recompute;

       property Actual:Byte read FActual write SetActual;
       property Error:String read FError write SetError;
       property Hint;
       property Value:Extended read GetValue write SetValue;
     published
       { Published declarations }
       property Anchors;
       property AutoSelect;
       property AutoSize;
       property BiDiMode;
       property BorderStyle;
       property CharCase;
       property Caption:string read FCaption write FCaption;
       property ColorOK:TColor read FColorOK write FColorOK;
       property ColorError:TColor read FColorError write FColorError;
       property Color;
       property Constraints;
       property Ctl3D;
       property DragCursor;
       property DragKind;
       property DragMode;
       property Enabled;
       property EditMask;
       property Font;
       property HelpProperties:integer read FHelpProperties write FHelpProperties;
       property HintOK:string read FHintOK write SetHintOK;
       property ImeMode;
       property ImeName;
       property MaxLength;
       property Measure:TMeasure read FMeasure write FMeasure;
       property Options:TOptions read FOptions write FOptions;
       property ParentBiDiMode;
       property ParentColor;
       property ParentCtl3D;
       property ParentFont;
       property ParentShowHint;
       property PasswordChar;
       property ReadOnly;
       property Round:TRound read FRound write FRound;
       property RoundUser:shortint read FRoundUser write FRoundUser;
       property ShowHint;
       property TabOrder;
       property TabStop;
       property Text;
       property Units:TUnits read FUnits write SetUnits;
       property UnitLabel:TLabel read FLabel write FLabel;
       property Visible;

       property OnChange;
       property OnClick;
       property OnCompute:TComputeEvent read FCompute write FCompute;
       property OnDblClick;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDock;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnLabelChange:TNotifyEvent read FLabelChange write FLabelChange;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnStartDock;
       property OnStartDrag;
     end;

     TsiComboEdit = class(TCustomComboEdit)
     private
       FActual:Byte;         {relativni poradi aktualni jednotky}
       FCaption:String;      {n·zev, pÌöe se p¯ed jednotku}
       FColorOK:TColor;      {pozadÌ}
       FColorError:TColor;   {pozadÌ p¯i chybÏ}
       FError:string;        {popis chyby, '' = nenÌ chyba}
       FHelpProperties:integer;
       FHintOK:string;       {n·povÏda}
       FLabel:TLabel;        {sprateleny label pro zobrazeni jednotky}
       FMenu:TPopupMenu;     {odkaz na menu}
       FUnitMenu:TMenuItem;
       FParser:TMathParser;  {odkaz na vypocetni system}
       FMeasure: TMeasure;   {druh omÏ¯ov·nÌ AutoCADem}
       FOptions:TOptions;
       FRound:TRound;        {nastaveni zaokrouhlovani vysledku}
       FRoundUser:shortint;  {uzivatelske zaokrouhlovani vysledku}
       FUnits:TUnits;        {druh jednotky}
       FUnitOffset:Byte;     {absolutni poradi prvni jednotky}

       FLabelChange:TNotifyEvent; {zmenila se jednotka}
       FCompute:TComputeEvent;    {vypocet hodnoty}

       procedure OnItemClick(Sender:TObject);
       procedure OnPopup(Sender:TObject);

       procedure SetActual(Data:Byte);
       procedure SetError(Data:string);
       procedure SetHintOK(Data:string);
       procedure SetUnits(Data:TUnits);
       procedure SetValue(Data:Extended);
       function GetValue:Extended;

       function NewMItem(Caption,Name:string;Checked:boolean;ImIndex:integer;Short:TShortCut):TMenuItem;
       procedure WMdestroy(var Message: TMessage); message WM_DESTROY;
     protected
       procedure CreateWnd; override;
       procedure DestroyWnd; override;
     public
       { Public declarations }
       constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
       procedure Recompute;

       property Actual:Byte read FActual write SetActual;
       property Error:String read FError write SetError;
       property Hint;
       property Value:Extended read GetValue write SetValue;
     published
       property Alignment;
       property AutoSelect;
       property BorderStyle;
       property ButtonHint;
       property CharCase;
       property Caption:string read FCaption write FCaption;
       property ColorOK:TColor read FColorOK write FColorOK;
       property ColorError:TColor read FColorError write FColorError;
       property ClickKey;
       property Color;
       property Ctl3D;
       property DirectInput;
       property DragCursor;
       property DragMode;
       property EditMask;
       property Enabled;
       property Font;
       property HelpProperties:integer read FHelpProperties write FHelpProperties;
       property HintOK:string read FHintOK write SetHintOK;
       property GlyphKind;
       { Ensure GlyphKind is published before Glyph and ButtonWidth }
       property Glyph;
       property ButtonWidth;
       property HideSelection;
       property Anchors;
       property BiDiMode;
       property Constraints;
       property DragKind;
       property ParentBiDiMode;
       property ImeMode;
       property ImeName;
       property MaxLength;
       property Measure:TMeasure read FMeasure write FMeasure;
       property NumGlyphs;
       property OEMConvert;
       property Options:TOptions read FOptions write FOptions;
       property ParentColor;
       property ParentCtl3D;
       property ParentFont;
       property ParentShowHint;
       property PopupMenu;
       property ReadOnly;
       property Round:TRound read FRound write FRound;
       property RoundUser:shortint read FRoundUser write FRoundUser;
       property ShowHint;
       property TabOrder;
       property TabStop;
       property Text;
       property Units:TUnits read FUnits write SetUnits;
       property UnitLabel:TLabel read FLabel write FLabel;
       property Visible;

       property OnButtonClick;
       property OnChange;
       property OnClick;
       property OnCompute:TComputeEvent read FCompute write FCompute;
       property OnDblClick;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnLabelChange:TNotifyEvent read FLabelChange write FLabelChange;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnStartDrag;
       property OnEndDock;
       property OnStartDock;
    end;

var AutoCad, MSExcel, MSWord : Variant;

procedure Register;

{$R *.DCR}

implementation

uses Forms, SysUtils, Variants, Math, ImgList, Windows, ComObj, Registry;

var MenuPics : TImageList = nil;

type TConvType = ( toBase, fromBase );
type TConvProc = Function(Value,Param:Extended;ConvType:TConvType):Extended;

{prevod do interniho zobrazeni provede nasobeni parametrem}
{prevod do externiho zobrazeni provede deleni parametrem}
Function Multip(Value,Param:Extended;ConvType:TConvType):Extended;
begin
  if ConvType = toBase then result := Value * Param
  else if ConvType = fromBase then result := Value / Param
  else raise EMathError.Create('Nezn·m˝ zp˘sob konverze');
end;

const siSize=51;

const siData:array [0..siSize-1] of record
        Units:TUnits;
        LDescr:string[100];
        SDescr:string[10];
        Param:extended;  { parametr pro p¯epoËÌt·v·nÌ }
        Conv:TConvProc;  { p¯epoËÌt·vacÌ funkce }
      end = (
  {0}
  (Units:UN_m; LDescr:'Milimetr'; SDescr:'mm'; Param:0.001; Conv:Multip),
  (Units:UN_m; LDescr:'Centimetr'; SDescr:'cm'; Param:0.01; Conv:Multip),
  (Units:UN_m; LDescr:'Metr'; SDescr:'m'; Param:1.0; Conv:Multip),
  (Units:UN_m; LDescr:'Palec'; SDescr:'in'; Param:0.0254; Conv:Multip),
  (Units:UN_m; LDescr:'Stopa'; SDescr:'ft'; Param:0.3048; Conv:Multip),
  (Units:UN_m; LDescr:'Yard'; SDescr:'yd'; Param:0.9144; Conv:Multip),
  {6}
  (Units:UN_m2; LDescr:'Milimetr na 2'; SDescr:'mm2'; Param:0.001*0.001; Conv:Multip),
  (Units:UN_m2; LDescr:'Centimetr na 2'; SDescr:'cm2'; Param:0.01*0.01; Conv:Multip),
  (Units:UN_m2; LDescr:'Metr na 2'; SDescr:'m2'; Param:1.0; Conv:Multip),
  (Units:UN_m2; LDescr:'Palec na 2'; SDescr:'in2'; Param:0.0254*0.0254; Conv:Multip),
  (Units:UN_m2; LDescr:'Stopa na 2'; SDescr:'ft2'; Param:0.3048*0.3048; Conv:Multip),
  (Units:UN_m2; LDescr:'Yard na 2'; SDescr:'yd2'; Param:0.9144*0.9144; Conv:Multip),
  {12}
  (Units:UN_m3; LDescr:'Milimetr na 3'; SDescr:'mm3'; Param:0.001*0.001*0.001; Conv:Multip),
  (Units:UN_m3; LDescr:'Centimetr na 3'; SDescr:'cm3'; Param:0.01*0.01*0.01; Conv:Multip),
  (Units:UN_m3; LDescr:'Metr na 3'; SDescr:'m3'; Param:1.0; Conv:Multip),
  (Units:UN_m3; LDescr:'Palec na 3'; SDescr:'in3'; Param:0.0254*0.0254*0.0254; Conv:Multip),
  (Units:UN_m3; LDescr:'Stopa na 3'; SDescr:'ft3'; Param:0.3048*0.3048*0.3048; Conv:Multip),
  (Units:UN_m3; LDescr:'Yard na 3'; SDescr:'yd3'; Param:0.9144*0.9144*0.9144; Conv:Multip),
  {18}
  (Units:UN_m4; LDescr:'Milimetr na 4'; SDescr:'mm4'; Param:0.001*0.001*0.001*0.001; Conv:Multip),
  (Units:UN_m4; LDescr:'Centimetr na 4'; SDescr:'cm4'; Param:0.01*0.01*0.01*0.01; Conv:Multip),
  (Units:UN_m4; LDescr:'Metr na 4'; SDescr:'m4'; Param:1.0; Conv:Multip),
  (Units:UN_m4; LDescr:'Palec na 4'; SDescr:'in4'; Param:0.0254*0.0254*0.0254*0.0254; Conv:Multip),
  (Units:UN_m4; LDescr:'Stopa na 4'; SDescr:'ft4'; Param:0.3048*0.3048*0.3048*0.3048; Conv:Multip),
  (Units:UN_m4; LDescr:'Yard na 4'; SDescr:'yd4'; Param:0.9144*0.9144*0.9144*0.9144; Conv:Multip),
  {24}
  (Units:UN_W; LDescr:'Miliwatt'; SDescr:'mW'; Param:0.001; Conv:Multip),
  (Units:UN_W; LDescr:'Watt'; SDescr:'W'; Param:1.0; Conv:Multip),
  (Units:UN_W; LDescr:'Kilowatt'; SDescr:'kW'; Param:1000.0; Conv:Multip),
  (Units:UN_W; LDescr:'[kpm s-1]'; SDescr:'kpm s-1'; Param:9.80665; Conv:Multip),
  (Units:UN_W; LDescr:'K˘Ú'; SDescr:'k'; Param:735.5; Conv:Multip),
  {29}
  (Units:UN_N; LDescr:'Newton'; SDescr:'N'; Param:1.0; Conv:Multip),
  (Units:UN_N; LDescr:'[dyn]'; SDescr:'dyn'; Param:10e-5; Conv:Multip),
  (Units:UN_N; LDescr:'Kilopond'; SDescr:'kp'; Param:9.80665; Conv:Multip),
  (Units:UN_N; LDescr:'Sthen'; SDescr:'sn'; Param:10e3; Conv:Multip),
  {33}
  (Units:UN_Nm; LDescr:'Newtonmetr'; SDescr:'Nm'; Param:1.0; Conv:Multip),
  (Units:UN_Nm; LDescr:'[dyn cm]'; SDescr:'dyn cm'; Param:10e-7; Conv:Multip),
  (Units:UN_Nm; LDescr:'Kilopondmetr'; SDescr:'kp m'; Param:9.80665; Conv:Multip),
  {36}
  (Units:UN_s; LDescr:'Milisekunda'; SDescr:'ms'; Param:0.001; Conv:Multip),
  (Units:UN_s; LDescr:'Sekunda'; SDescr:'s'; Param:1.0; Conv:Multip),
  (Units:UN_s; LDescr:'Minuta'; SDescr:'min'; Param:60.0; Conv:Multip),
  (Units:UN_s; LDescr:'Hodina'; SDescr:'h'; Param:3600.0; Conv:Multip),
  {40}
  (Units:UN_1s; LDescr:'1/Milisekunda'; SDescr:'ms-1'; Param:1000.0; Conv:Multip),
  (Units:UN_1s; LDescr:'1/Sekunda'; SDescr:'s-1'; Param:1.0; Conv:Multip),
  (Units:UN_1s; LDescr:'1/Minuta'; SDescr:'min-1'; Param:1/60; Conv:Multip),
  (Units:UN_1s; LDescr:'1/Hodina'; SDescr:'h-1'; Param:1/3600; Conv:Multip),
  {44}
  (Units:UN_kg; LDescr:'Gram'; SDescr:'g'; Param:0.001; Conv:Multip),
  (Units:UN_kg; LDescr:'Kilogram'; SDescr:'kg'; Param:1.0; Conv:Multip),
  (Units:UN_kg; LDescr:'Tuna'; SDescr:'t'; Param:1000.0; Conv:Multip),
  (Units:UN_kg; LDescr:'[kp m-1 s2]'; SDescr:'kp m-1 s2'; Param:9.80665; Conv:Multip),
  (Units:UN_kg; LDescr:'Metrick˝ cent'; SDescr:'q'; Param:100.0; Conv:Multip),
  (Units:UN_kg; LDescr:'Libra'; SDescr:'lb'; Param:0.453592; Conv:Multip),
  (Units:UN_kg; LDescr:'Unce'; SDescr:'oz'; Param:0.0283495; Conv:Multip));

Function Zaokrouhli(Co:Extended; Rtype:TRound; Ruser:shortint):Extended;
Function Zaokr(Co:Extended;Na:shortint):Extended;
var mocnina:Extended;
begin
  mocnina:=Co*IntPower(10,Na);
  {round podporuje pouze longint, vypocet je upraven pro velka cisla}
  Result:=(Int(mocnina)+Round(Frac(mocnina)))/IntPower(10,Na);
end;
begin
  Case Rtype of
    roCSN:begin
      If Abs(Co)<10 then Result:=Zaokr(Co,3)
      else If Abs(Co)<100 then Result:=Zaokr(Co,2)
      else If Abs(Co)<1000 then Result:=Zaokr(Co,1)
      else Result:=Zaokr(Co,0);
    end;
    roUser:Result:=Zaokr(Co,Ruser);
    else Result:=Co;
  end;
end;

{ --- TsiEdit --------------------------------------------------------------- }

procedure TsiEdit.SetActual(Data:Byte);
var Trans:Extended;
begin
  if( FUnits<>UN_none ) and ( FActual<>data ) then begin
    {odökrtnutÌ souËasnÈ jednotky}
    FUnitMenu.Items[FActual].Checked:=false;

    {konverze na z·kladnÌ jednotku SI, m˘ûe dojÌt k chybÏ}
    try
      Trans:=Value;
      Error:='';
    except
      on E:Exception do Error:=E.message;
    end; {except}
    FActual:=Data; {zmÏna jednotky}

    {zaökrtnutÌ novÈ jednotky}
    FUnitMenu.Items[FActual].Checked:=true;
    {zmÏna n·pis˘}
    FLabel.Caption:=FCaption+' ['+siData[FUnitOffset+FActual].SDescr+']';
    if assigned(OnLabelChange) then OnLabelChange(self);

    {p¯epoËÌt·nÌ a konverze ze z·kladnÌ jednotky, m˘ûe dojÌt k chybÏ}
    try
      if assigned(OnCompute) then OnCompute(self,Trans);
      Value:=Trans;
      Error:='';
    except
      on E:Exception do Error:=E.message;
    end; {except}
  end;
end;

Procedure TsiEdit.SetError(Data:string);
begin
  if Data='' then begin {nenÌ chyba}
    Hint:=FHintOK;
    Color:=FColorOK;
  end else begin {je chyba}
    Hint:=Data;
    Color:=FColorError;
  end;
  FError:=Data;
end;

Procedure TsiEdit.SetHintOK(Data:string);
begin
  FHintOK:=Data;
  {nenÌ-li chyba, nastav takÈ glob·lnÌ n·povÏdu}
  If FError='' then Hint:=Data;
end;

procedure TsiEdit.SetUnits(Data:TUnits);
var i:integer;
begin
  if FUnits<>Data then begin
    FUnits:=Data;

    if FUnits <> UN_none then begin
      i:=0;
      {vyhledat soubor pozadovanych jednotek}
      while siData[i].Units <> FUnits do i:=i+1;
      FUnitOffset := i;
      {vyhledat a nastavit implicitni jednotku}
      while siData[i].Param <> 1.0 do i:=i+1;
      FActual := i - FUnitOffset;
    end;
  end;
end;

Function TsiEdit.GetValue:Extended;
begin
  try
    FParser.ParseString := Text;
    FParser.Parse;
    if FUnits<>UN_none
      then Result:=siData[FUnitOffset+FActual].Conv(FParser.ParseValue,siData[FUnitOffset+FActual].Param,toBase)
      else Result:=FParser.ParseValue; {zadna jednotka}
    Error:='';
  except
    on E:Exception do begin
      Error:=E.message;
      raise; {reraise exception, pro dalöÌ zpracov·nÌ}
    end;
  end; {except}
end;

Procedure TsiEdit.SetValue(Data:Extended);
var Rounded:Extended;
begin
  if FUnits<>UN_none
    then Rounded:=Zaokrouhli(siData[FUnitOffset+FActual].Conv(Data,siData[FUnitOffset+FActual].Param,fromBase),FRound,FRoundUser)
    else Rounded:=Zaokrouhli(Data,FRound,FRoundUser); {zadna jednotka}
  Text:=FloatToStrF(Rounded,ffGeneral,15,2);
end;

{konstrukce a implicitnÌ nastavenÌ}
constructor TsiEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FParser:=TMathParser.Create(self);

  FMenu:=TPopupMenu.Create(self);
  FMenu.Name:=Name+'Popup';
  FMenu.Images:=MenuPics;
  FMenu.OnPopup:=OnPopup;
  PopupMenu:=FMenu;

  FColorOK:=clWindow;
  FColorError:=$00C8FFFF;
  FMeasure:=meNone;
  FOptions:=[ RoundItem ];
  FUnits:=UN_none;
  Text:='0';
  FRound:=roCSN;
  FRoundUser:=3;

  ControlStyle := ControlStyle - [csSetCaption];
end;

{destrukce}
destructor TsiEdit.Destroy;
begin
  FMenu.Free;
  FParser.Free;
  inherited Destroy;
end;

Function TsiEdit.NewMItem(Caption,Name:string;Checked:boolean;ImIndex:integer;Short:TShortCut):TMenuItem;
begin
  Result:=TMenuItem.Create(self);
  Result.Caption:=Caption;
  Result.Name:=Name;
  Result.Checked:=Checked;
  Result.ShortCut:=Short;
  Result.ImageIndex:=ImIndex;
  Result.OnClick:=OnItemClick;
end;

procedure TsiEdit.CreateWnd;
var i,j: integer;
    firsepar, addsend: boolean;
    registry:TRegistry;
    FSendMenu:TMenuItem;
begin
  inherited CreateWnd;
  firsepar := false;

  if not(csDesigning in ComponentState) then begin
    if SaveState in FOptions then begin
      registry := TRegistry.Create;
      with registry do
      try
        OpenKey('Software\Gotthard\'+Application.Name+'\'+Name,true);
        FActual:=ReadInteger('Actual');
        ReadBinaryData('Round',FRound,SizeOf(FRound));
        FRoundUser:=ReadInteger('RoundUser');
        Text:=ReadString('Text');
      except
      end;
      registry.Destroy;
    end;
  end;

  if FUnits<>UN_none then begin
    {vytvo¯enÌ submenu}
    FUnitMenu:=NewMItem('&Jednotka','unit',false,-1,0);

    j:=0;
    for i:=0 to siSize-1 do begin
      if siData[i].Units = FUnits then begin
        if j = FActual then begin
          FUnitMenu.Insert(j,NewMItem(siData[i].LDescr,'item'+IntToStr(j),true,-1,0));
        end else begin
          FUnitMenu.Insert(j,NewMItem(siData[i].LDescr,'item'+IntToStr(j),false,-1,0));
        end;
        j:=j+1;
      end;
    end;
    if j>0 then begin
      FMenu.Items.Add(FUnitMenu);
      firsepar := true;
    end;

    {poË·teËnÌ nastavenÌ Labelu}
    FLabel.Caption:=FCaption+' ['+siData[FUnitOffset+FActual].SDescr+']';
    if assigned(OnLabelChange) then OnLabelChange(self);
  end else begin
    {û·dn· jednotka}
    FLabel.Caption:=FCaption;
    if assigned(OnLabelChange) then OnLabelChange(self);
  end;

  // kontrola spr·vnosti spojenÌ s AutoCADem
  if( FMeasure <> meNone ) and ( VarType( AutoCad ) = varDispatch ) then begin
    FMenu.Items.Add(NewMItem('&OdmÏ¯it...','measure',false,4,0));
    firsepar := true;
  end;
  if firsepar then FMenu.Items.Add(NewLine);

  {z·kladnÌ Ë·st menu}
  FMenu.Items.Add(NewMItem('&Vyjmout','cut',false,0,ShortCut(Word('X'),[ssCtrl])));
  FMenu.Items.Add(NewMItem('&KopÌrovat','copy',false,1,ShortCut(Word('C'),[ssCtrl])));
  FMenu.Items.Add(NewMItem('V&loûit','paste',false,2,ShortCut(Word('V'),[ssCtrl])));
  FMenu.Items.Add(NewMItem('Od&stranit','delete',false,3,0));
  FMenu.Items.Add(NewMItem('Vybr&at vöe','select',false,-1,0));

  addsend := false;
  FSendMenu:=NewMItem('&Odeslat','send',false,-1,0);
  // kontrola spr·vnosti spojenÌ s Microsoft Excelem
  if( VarType( MSExcel ) = varDispatch ) then begin
    FSendMenu.Add(NewMItem('Do &Excelu','send_excel',false,5,0));
    addsend := true;
  end;
  // kontrola spr·vnosti spojenÌ s Microsoft Wordem
  if( VarType( MSWord ) = varDispatch ) then begin
    FSendMenu.Add(NewMItem('Do &Wordu','send_word',false,6,0));
    addsend := true;
  end;
  // oddÏlovaË
  if addsend or ( RoundItem in FOptions ) then FMenu.Items.Add(NewLine);
  // popup-menu pro odesÌl·nÌ
  if( addsend ) then FMenu.Items.Add( FSendMenu ) else FSendMenu.Free;
  // vlastnosti zaokrouhlov·nÌ
  if RoundItem in FOptions then
    FMenu.Items.Add(NewMItem('Vlast&nosti...','setup',false,-1,0));
end;

procedure TsiEdit.WMdestroy(var Message: TMessage);
var registry:TRegistry;
begin
  if not(csDesigning in ComponentState) then begin
    if SaveState in FOptions then begin
      registry := TRegistry.Create;
      with registry do begin
        OpenKey('Software\Gotthard\'+Application.Name+'\'+Name,true);
        WriteInteger('Actual',Actual);
        WriteBinaryData('Round',FRound,SizeOf(FRound));
        WriteInteger('RoundUser',RoundUser);
        WriteString('Text',Text);
      end;
      registry.Destroy;
    end;
  end;

  inherited;
end;

procedure TsiEdit.DestroyWnd;
var i:integer;
begin
  for i:=0 to FMenu.Items.Count-1 do begin
    FMenu.Items[0].Destroy;
  end;
  inherited DestroyWnd;
end;

procedure TsiEdit.OnPopup(Sender:TObject);
begin
  SetFocus;
end;

procedure TsiEdit.OnItemClick(Sender:TObject);
var itemname:string;
    trans:Extended;
    cursor:TCursor;

    Kresba: Variant;
    Cislo:Extended;
begin
  if ((Sender as TMenuItem).Name) = 'cut' then begin
    CutToClipboard;
  end else if ((Sender as TMenuItem).Name) = 'copy' then begin
    CopyToClipboard;
  end else if ((Sender as TMenuItem).Name) = 'paste' then begin
    PasteFromClipboard;
  end else if ((Sender as TMenuItem).Name) = 'delete' then begin
    ClearSelection;
  end else if ((Sender as TMenuItem).Name) = 'select' then begin
    SelectAll;
  end else if ((Sender as TMenuItem).Name) = 'measure' then begin
    // nastav kurzor na p¯es˝pacÌ hodiny
    cursor := Screen.Cursor;
    Screen.Cursor := crHourglass;
    try
      Kresba := AutoCad.ActiveDocument;
      // p¯epnout se na AutoCad
      ShowWindow( Kresba.HWND, SW_SHOWNORMAL );
      SetForegroundWindow( GetParent(Kresba.HWND) );
      case FMeasure of
        meDistance: begin
          Cislo := Kresba.Utility.GetDistance(,'Specify distance:');
          Text:=FloatToStrF(Zaokrouhli(Cislo,FRound,FRoundUser),ffGeneral,15,2);
        end;
      end;
      // p¯epnout se zpÏt na Kalkul·tor
      Application.BringToFront;
    except
      Application.MessageBox('Nemohu se spojit s AutoCADem.'#13'Spusùte jej a otev¯ete obr·zek, kter˝ chcete mÏ¯it.','Chyba',MB_OK+MB_ICONEXCLAMATION);
    end;
    // odnov p˘vodnÌ kurzor
    Screen.Cursor := cursor;
  end else if ((Sender as TMenuItem).Name) = 'send_excel' then begin
    try
      MSExcel.ActiveCell.Value := Text;
    except
      Application.MessageBox('Nemohu se spojit s Microsoft Excelem.','Chyba',MB_OK+MB_ICONEXCLAMATION);
    end;
  end else if ((Sender as TMenuItem).Name) = 'send_word' then begin
    try
      MSWord.Selection.InsertAfter( Text );
    except
      Application.MessageBox('Nemohu se spojit s Microsoft Wordem.','Chyba',MB_OK+MB_ICONEXCLAMATION);
    end;
  end else if ((Sender as TMenuItem).Name) = 'setup' then begin
    Application.CreateForm(TFoProperties, FoProperties);
    FoProperties.HelpContext:=FHelpProperties;
    FoProperties.FSetSel(Round);
    FoProperties.EdUser.Text:=IntToStr(RoundUser);
    if FoProperties.ShowModal=mrOK then begin
      try
        Trans:=Value;
        Error:='';
      except
        on E:Exception do Error:=E.message;
      end; {except}
      FRound:=FoProperties.FGetSel;
      if Round=roUser then FRoundUser:=StrToInt(FoProperties.EdUser.Text);
      try
        if assigned(OnCompute) then OnCompute(self,Trans);
        Value:=Trans;
        Error:='';
      except
        on E:Exception do Error:=E.message;
      end; {except}
    end;
    FoProperties.Destroy;
  end else if copy((Sender as TMenuItem).Name,1,4)='item' then begin
    {byla zvolena nÏjak· jednotka}
    itemname:=(Sender as TMenuItem).Name;
    Actual:=strtoint(Copy(itemname,5,length(itemname)));
  end;
end;

procedure TsiEdit.Recompute;
var Trans:Extended;
begin
  If assigned(OnCompute) then begin
    try
      OnCompute(self,Trans);
      Value:=Trans;
      Error:='';
    except
      on E:Exception do begin
        Text:='';
        Error:=E.message;
      end;
    end; {except}
  end;
end;

{ --- TsiComboEdit ---------------------------------------------------------- }

procedure TsiComboEdit.SetActual(Data:Byte);
var Trans:Extended;
begin
  if( FUnits<>UN_none ) and ( FActual<>data ) then begin
    {odökrtnutÌ souËasnÈ jednotky}
    FUnitMenu.Items[FActual].Checked:=false;

    {konverze na z·kladnÌ jednotku SI, m˘ûe dojÌt k chybÏ}
    try
      Trans:=Value;
      Error:='';
    except
      on E:Exception do Error:=E.message;
    end; {except}
    FActual:=Data; {zmÏna jednotky}

    {zaökrtnutÌ novÈ jednotky}
    FUnitMenu.Items[FActual].Checked:=true;
    {zmÏna n·pis˘}
    FLabel.Caption:=FCaption+' ['+siData[FUnitOffset+FActual].SDescr+']';
    if assigned(OnLabelChange) then OnLabelChange(self);

    {p¯epoËÌt·nÌ a konverze ze z·kladnÌ jednotky, m˘ûe dojÌt k chybÏ}
    try
      if assigned(OnCompute) then OnCompute(self,Trans);
      Value:=Trans;
      Error:='';
    except
      on E:Exception do Error:=E.message;
    end; {except}
  end;
end;

Procedure TsiComboEdit.SetError(Data:string);
begin
  if Data='' then begin {nenÌ chyba}
    Hint:=FHintOK;
    Color:=FColorOK;
  end else begin {je chyba}
    Hint:=Data;
    Color:=FColorError;
  end;
  FError:=Data;
end;

Procedure TsiComboEdit.SetHintOK(Data:string);
begin
  FHintOK:=Data;
  {nenÌ-li chyba, nastav takÈ glob·lnÌ n·povÏdu}
  If FError='' then Hint:=Data;
end;

procedure TsiComboEdit.SetUnits(Data:TUnits);
var i:integer;
begin
  if FUnits<>Data then begin
    FUnits:=Data;

    if FUnits <> UN_none then begin
      i:=0;
      {vyhledat soubor pozadovanych jednotek}
      while siData[i].Units <> FUnits do i:=i+1;
      FUnitOffset := i;
      {vyhledat a nastavit implicitni jednotku}
      while siData[i].Param <> 1.0 do i:=i+1;
      FActual := i - FUnitOffset;
    end;
  end;
end;

Function TsiComboEdit.GetValue:Extended;
begin
  try
    FParser.ParseString := Text;
    FParser.Parse;
    if FUnits<>UN_none
      then Result:=siData[FUnitOffset+FActual].Conv(FParser.ParseValue,siData[FUnitOffset+FActual].Param,toBase)
      else Result:=FParser.ParseValue; {zadna jednotka}
    Error:='';
  except
    on E:Exception do begin
      Error:=E.message;
      raise; {reraise exception, pro dalöÌ zpracov·nÌ}
    end;
  end; {except}
end;

Procedure TsiComboEdit.SetValue(Data:Extended);
var Rounded:Extended;
begin
  if FUnits<>UN_none
    then Rounded:=Zaokrouhli(siData[FUnitOffset+FActual].Conv(Data,siData[FUnitOffset+FActual].Param,fromBase),FRound,FRoundUser)
    else Rounded:=Zaokrouhli(Data,FRound,FRoundUser); {zadna jednotka}
  Text:=FloatToStrF(Rounded,ffGeneral,15,2);
end;

{konstrukce a implicitnÌ nastavenÌ}
constructor TsiComboEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FParser:=TMathParser.Create(self);

  FMenu:=TPopupMenu.Create(self);
  FMenu.Name:=Name+'Popup';
  FMenu.Images:=MenuPics;
  FMenu.OnPopup:=OnPopup;
  PopupMenu:=FMenu;

  Text:='0';
  FColorOK:=clWindow;
  FColorError:=$00C8FFFF;
  FMeasure:=meNone;
  FOptions:=[ RoundItem ];
  FRound:=roCSN;
  FRoundUser:=3;
  FUnits:=UN_none;

  ControlStyle := ControlStyle - [csSetCaption];
end;

{destrukce}
destructor TsiComboEdit.Destroy;
begin
  FMenu.Free;
  FParser.Free;
  inherited Destroy;
end;

Function TsiComboEdit.NewMItem(Caption,Name:string;Checked:boolean;ImIndex:integer;Short:TShortCut):TMenuItem;
begin
  Result:=TMenuItem.Create(self);
  Result.Caption:=Caption;
  Result.Name:=Name;
  Result.Checked:=Checked;
  Result.ShortCut:=Short;
  Result.ImageIndex:=ImIndex;
  Result.OnClick:=OnItemClick;
end;

procedure TsiComboEdit.CreateWnd;
var i,j: integer;
    firsepar, addsend: boolean;
    registry:TRegistry;
    FSendMenu:TMenuItem;
begin
  inherited CreateWnd;
  firsepar := false;

  if not(csDesigning in ComponentState) then begin
    if SaveState in FOptions then begin
      registry := TRegistry.Create;
      with registry do
      try
        OpenKey('Software\Gotthard\'+Application.Name+'\'+Name,true);
        FActual:=ReadInteger('Actual');
        ReadBinaryData('Round',FRound,SizeOf(FRound));
        FRoundUser:=ReadInteger('RoundUser');
        Text:=ReadString('Text');
      except
      end;
      registry.Destroy;
    end;
  end;

  if FUnits<>UN_none then begin
    {vytvo¯enÌ submenu}
    FUnitMenu:=NewMItem('&Jednotka','unit',false,-1,0);

    j:=0;
    for i:=0 to siSize-1 do begin
      if siData[i].Units = FUnits then begin
        if j = FActual then begin
          FUnitMenu.Insert(j,NewMItem(siData[i].LDescr,'item'+IntToStr(j),true,-1,0));
        end else begin
          FUnitMenu.Insert(j,NewMItem(siData[i].LDescr,'item'+IntToStr(j),false,-1,0));
        end;
        j:=j+1;
      end;
    end;
    if j>0 then begin
      FMenu.Items.Add(FUnitMenu);
      firsepar := true;
    end;

    {poË·teËnÌ nastavenÌ Labelu}
    FLabel.Caption:=FCaption+' ['+siData[FUnitOffset+FActual].SDescr+']';
    if assigned(OnLabelChange) then OnLabelChange(self);
  end else begin
    {û·dn· jednotka}
    FLabel.Caption:=FCaption;
    if assigned(OnLabelChange) then OnLabelChange(self);
  end;

  // kontrola spr·vnosti spojenÌ s AutoCADem
  if( FMeasure <> meNone ) and ( VarType( AutoCad ) = varDispatch ) then begin
    FMenu.Items.Add(NewMItem('&OdmÏ¯it...','measure',false,4,0));
    firsepar := true;
  end;
  if firsepar then FMenu.Items.Add(NewLine);

  {z·kladnÌ Ë·st menu}
  FMenu.Items.Add(NewMItem('&Vyjmout','cut',false,0,ShortCut(Word('X'),[ssCtrl])));
  FMenu.Items.Add(NewMItem('&KopÌrovat','copy',false,1,ShortCut(Word('C'),[ssCtrl])));
  FMenu.Items.Add(NewMItem('V&loûit','paste',false,2,ShortCut(Word('V'),[ssCtrl])));
  FMenu.Items.Add(NewMItem('Od&stranit','delete',false,3,0));
  FMenu.Items.Add(NewMItem('Vybr&at vöe','select',false,-1,0));

  addsend := false;
  FSendMenu:=NewMItem('&Odeslat','send',false,-1,0);
  // kontrola spr·vnosti spojenÌ s Microsoft Excelem
  if( VarType( MSExcel ) = varDispatch ) then begin
    FSendMenu.Add(NewMItem('Do &Excelu','send_excel',false,5,0));
    addsend := true;
  end;
  // kontrola spr·vnosti spojenÌ s Microsoft Wordem
  if( VarType( MSWord ) = varDispatch ) then begin
    FSendMenu.Add(NewMItem('Do &Wordu','send_word',false,6,0));
    addsend := true;
  end;
  // oddÏlovaË
  if addsend or ( RoundItem in FOptions ) then FMenu.Items.Add(NewLine);
  // popup-menu pro odesÌl·nÌ
  if( addsend ) then FMenu.Items.Add( FSendMenu ) else FSendMenu.Free;
  // vlastnosti zaokrouhlov·nÌ
  if RoundItem in FOptions then
    FMenu.Items.Add(NewMItem('Vlast&nosti...','setup',false,-1,0));
end;

procedure TsiComboEdit.WMdestroy(var Message: TMessage);
var registry:TRegistry;
begin
  if not(csDesigning in ComponentState) then begin
    if SaveState in FOptions then begin
      registry := TRegistry.Create;
      with registry do begin
        OpenKey('Software\Gotthard\'+Application.Name+'\'+Name,true);
        WriteInteger('Actual',Actual);
        WriteBinaryData('Round',FRound,SizeOf(FRound));
        WriteInteger('RoundUser',RoundUser);
        WriteString('Text',Text);
      end;
      registry.Destroy;
    end;
  end;

  inherited;
end;

procedure TsiComboEdit.DestroyWnd;
var i:integer;
begin
  for i:=0 to FMenu.Items.Count-1 do FMenu.Items[0].Destroy;
  inherited DestroyWnd;
end;

procedure TsiComboEdit.OnPopup(Sender:TObject);
begin
  SetFocus;
end;

procedure TsiComboEdit.OnItemClick(Sender:TObject);
var itemname:string;
    trans:Extended;
    cursor:TCursor;

    Kresba: Variant;
    Cislo:Extended;
begin
  if ((Sender as TMenuItem).Name) = 'cut' then begin
    CutToClipboard;
  end else if ((Sender as TMenuItem).Name) = 'copy' then begin
    CopyToClipboard;
  end else if ((Sender as TMenuItem).Name) = 'paste' then begin
    PasteFromClipboard;
  end else if ((Sender as TMenuItem).Name) = 'delete' then begin
    ClearSelection;
  end else if ((Sender as TMenuItem).Name) = 'select' then begin
    SelectAll;
  end else if ((Sender as TMenuItem).Name) = 'measure' then begin
    // nastav kurzor na p¯es˝pacÌ hodiny
    cursor := Screen.Cursor;
    Screen.Cursor := crHourglass;
    try
      Kresba := AutoCad.ActiveDocument;
      // p¯epnout se na AutoCad
      ShowWindow( Kresba.HWND, SW_SHOWNORMAL );
      SetForegroundWindow( GetParent(Kresba.HWND) );
      case FMeasure of
        meDistance: begin
          Cislo := Kresba.Utility.GetDistance(,'Specify distance:');
          Text:=FloatToStrF(Zaokrouhli(Cislo,FRound,FRoundUser),ffGeneral,15,2);
        end;
      end;
      // p¯epnout se zpÏt na Kalkul·tor
      Application.BringToFront;
    except
      Application.MessageBox('Nemohu se spojit s AutoCADem.'#13'Spusùte jej a otev¯ete obr·zek, kter˝ chcete mÏ¯it.','Chyba',MB_OK+MB_ICONEXCLAMATION);
    end;
    // obnov p˘vodnÌ kurzor
    Screen.Cursor := cursor;
  end else if ((Sender as TMenuItem).Name) = 'send_excel' then begin
    try
      MSExcel.ActiveCell.Value := Text;
    except
      Application.MessageBox('Nemohu se spojit s Microsoft Excelem.','Chyba',MB_OK+MB_ICONEXCLAMATION);
    end;
  end else if ((Sender as TMenuItem).Name) = 'send_word' then begin
    try
      MSWord.Selection.InsertAfter( Text );
    except
      Application.MessageBox('Nemohu se spojit s Microsoft Wordem.','Chyba',MB_OK+MB_ICONEXCLAMATION);
    end;
  end else if ((Sender as TMenuItem).Name) = 'setup' then begin
    Application.CreateForm(TFoProperties, FoProperties);
    FoProperties.HelpContext:=FHelpProperties;
    FoProperties.FSetSel(Round);
    FoProperties.EdUser.Text:=IntToStr(RoundUser);
    if FoProperties.ShowModal=mrOK then begin
      try
        Trans:=Value;
        Error:='';
      except
        on E:Exception do Error:=E.message;
      end; {except}
      FRound:=FoProperties.FGetSel;
      if Round=roUser then FRoundUser:=StrToInt(FoProperties.EdUser.Text);
      try
        if assigned(OnCompute) then OnCompute(self,Trans);
        Value:=Trans;
        Error:='';
      except
        on E:Exception do Error:=E.message;
      end; {except}
    end;
    FoProperties.Destroy;
  end else if copy((Sender as TMenuItem).Name,1,4)='item' then begin
    {byla zvolena nÏjak· jednotka}
    itemname:=(Sender as TMenuItem).Name;
    Actual:=strtoint(Copy(itemname,5,length(itemname)));
  end;
end;

procedure TsiComboEdit.Recompute;
var Trans:Extended;
begin
  If assigned(OnCompute) then begin
    try
      OnCompute(self,Trans);
      Value:=Trans;
      Error:='';
    except
      on E:Exception do begin
        Text:='';
        Error:=E.message;
      end;
    end; {except}
  end;
end;

{ --------------------------------------------------------------------------- }

procedure Register;
begin
  RegisterComponents('Additional', [TsiEdit, TsiComboEdit]);
end;

initialization

  // naËtenÌ obr·zk˘ do menu
  MenuPics := TImageList.Create( nil );
  MenuPics.ResourceLoad(rtBitmap,'MENUPICS',clFuchsia);

finalization

  MenuPics.Free;

end.

