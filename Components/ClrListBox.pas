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

    $Id: AnyBnfFile.cpp 22 2007-09-26 17:51:41Z gotthardp $
}

{$B-}
unit ClrListBox;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry;

type TOptions = set of ( SaveState );
     TItemColorEvent = procedure (Control: TWinControl; Index: Integer; var Color: TColor) of object;

     TClrListBox = class(TListBox)
     private
       { Private declarations }
       FOnColorItem:TItemColorEvent;
       procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
     protected
       { Protected declarations }
       procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
     public
       { Public declarations }
       constructor Create(AOwner : TComponent); override;
     published
       { Published declarations }
       property OnColorItem:TItemColorEvent read FOnColorItem write FOnColorItem;
     end;

     TClrComboBox = class(TCustomComboBox)
     private
       { Private declarations }
       FOnCreate:TNotifyEvent;
       FOnColorItem:TItemColorEvent;
       FOptions:TOptions;
       procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
     protected
       { Protected declarations }
       procedure CreateWnd; override;
       procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
       procedure MeasureItem(Index: Integer; var Height: Integer); override;
     public
       { Public declarations }
       constructor Create(AOwner : TComponent); override;
     published
       { Published declarations }
       property Style; {Must be published before Items}
       property Anchors;
       property BiDiMode;
       property Color;
       property Constraints;
       property Ctl3D;
       property DragCursor;
       property DragKind;
       property DragMode;
       property DropDownCount;
       property Enabled;
       property Font;
       property ImeMode;
       property ImeName;
       property ItemHeight;
       property Items;
       property MaxLength;
       property Options:TOptions read FOptions write FOptions;
       property ParentBiDiMode;
       property ParentColor;
       property ParentCtl3D;
       property ParentFont;
       property ParentShowHint;
       property PopupMenu;
       property ShowHint;
       property Sorted;
       property TabOrder;
       property TabStop;
       property Text;
       property Visible;
       property OnChange;
       property OnClick;
       property OnCloseUp;
       property OnColorItem:TItemColorEvent read FOnColorItem write FOnColorItem;
       property OnContextPopup;
       property OnCreate:TNotifyEvent read FOnCreate write FOnCreate;
       property OnDblClick;
       property OnDragDrop;
       property OnDragOver;
       property OnDrawItem;
       property OnDropDown;
       property OnEndDock;
       property OnEndDrag;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnMeasureItem;
       property OnSelect;
       property OnStartDock;
       property OnStartDrag;
     end;

procedure Register;

{$R *.DCR}

implementation

{ --- TClrListBox ----------------------------------------------------------- }

constructor TClrListBox.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Height:=21;
  Style := lbOwnerDrawVariable; {!povinne!}
end;

procedure TClrListBox.DrawItem(Index: Integer; Rect: TRect;State: TOwnerDrawState);
begin
  Canvas.FillRect(Rect);
  if Index < Items.Count then Canvas.TextOut(Rect.Left + 2, Rect.Top, Items[Index]);
end;

procedure TClrListBox.CNDrawItem(var Message: TWMDrawItem);
var State: TOwnerDrawState;
    Color:TColor;
begin
  with Message.DrawItemStruct^ do begin
    State := TOwnerDrawState(LongRec(itemState).Lo);
    Canvas.Handle := hDC;
    Canvas.Font := Font;
    Canvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in State) then begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
    end else begin
      Color := clBtnText;
      if not(csDesigning in ComponentState) then begin
        if assigned(OnColorItem) then OnColorItem(self, itemID, Color);
      end;
      Canvas.Font.Color := Color;
    end;
    if Integer(itemID) >= 0 then DrawItem(itemID, rcItem, State)
                            else Canvas.FillRect(rcItem);
    if odFocused in State then DrawFocusRect(hDC, rcItem);
    Canvas.Handle := 0;
  end;
end;

{ --- TClrComboBox ---------------------------------------------------------- }

constructor TClrComboBox.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Style := csOwnerDrawVariable; {!povinne!}
  FOptions := [];
end;

procedure TClrComboBox.DrawItem(Index: Integer; Rect: TRect;State: TOwnerDrawState);
var Color:TColor;
begin
  if odSelected in State then begin
    Canvas.Brush.Color := clHighlight;
    Canvas.Font.Color := clHighlightText;
  end else begin
    Color := clBtnText;
    if not(csDesigning in ComponentState) then begin
      if assigned(OnColorItem) then OnColorItem(self, Index, Color);
    end;
    Canvas.Font.Color := Color;
  end;

  if Index >= 0 then begin
    Canvas.FillRect(Rect);
    if Index < Items.Count then Canvas.TextOut(Rect.Left + 2, Rect.Top, Items[Index]);
  end else begin
    Canvas.FillRect(Rect);
  end;
end;

procedure TClrComboBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  Height := Abs(Font.Height) + 4;
end;

procedure TClrComboBox.CreateWnd;
var registry:TRegistry;
begin
  inherited CreateWnd;

  if not(csDesigning in ComponentState) then begin
    if assigned(OnCreate) then OnCreate(self);

    if SaveState in FOptions then begin
      registry := TRegistry.Create;
      with registry do
      try
        OpenKey('Software\Gotthard\'+Application.Name+'\'+Name,true);
        ItemIndex:=ReadInteger('Index');
      except
      end;
      registry.Destroy;
    end;

  end;
end;

procedure TClrComboBox.WMDestroy(var Message: TMessage);
var registry:TRegistry;
begin
  if not(csDesigning in ComponentState) then begin
    if SaveState in FOptions then begin
      registry := TRegistry.Create;
      with registry do
      try
        OpenKey('Software\Gotthard\'+Application.Name+'\'+Name,true);
        WriteInteger('Index',ItemIndex);
      except
      end;
      registry.Destroy;
    end;
  end;

  inherited;
end;

{ --------------------------------------------------------------------------- }

procedure Register;
begin
  RegisterComponents('Additional', [TClrListBox, TClrComboBox]);
end;

end.
