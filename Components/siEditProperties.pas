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
unit siEditProperties;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RxGrdCpt, Buttons;

type TRound = (roNone,roCSN,roUser);

type TFoProperties = class(TForm)
    BuOK: TButton;
    BuStorno: TButton;
    GroupBox1: TGroupBox;
    RaNone: TRadioButton;
    RaNorma: TRadioButton;
    RaUser: TRadioButton;
    EdUser: TEdit;
       procedure RaNoneClick(Sender: TObject);
       procedure RaNormaClick(Sender: TObject);
       procedure RaUserClick(Sender: TObject);
       procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
     public
       procedure FSetSel(Data:TRound);
       function FGetSel:TRound;
       property Selected:TRound read FGetSel write FSetSel;
     end;

var FoProperties: TFoProperties;

implementation

{$R *.DFM}

function TFoProperties.FGetSel:TRound;
begin
  if RaNorma.Checked then result:=roCSN
  else if RaUser.Checked then result:=roUser
  else result:=roNone; { RaNone nebo cokoli jineho }
end;

procedure TFoProperties.FSetSel(Data:TRound);
begin
  case data of
    roNone:begin
      RaNone.Checked:=True;
      RaNorma.Checked:=False;
      RaUser.Checked:=False;

      EdUser.Enabled:=False;
    end;
    roCSN: begin
      RaNone.Checked:=False;
      RaNorma.Checked:=True;
      RaUser.Checked:=False;

      EdUser.Enabled:=False;
    end;
    roUser: begin
      RaNone.Checked:=False;
      RaNorma.Checked:=False;
      RaUser.Checked:=True;

      EdUser.Enabled:=True;
    end;
  end;
end;

procedure TFoProperties.RaNoneClick(Sender: TObject);
begin
  Selected:=roNone;
end;

procedure TFoProperties.RaNormaClick(Sender: TObject);
begin
  Selected:=roCSN;
end;

procedure TFoProperties.RaUserClick(Sender: TObject);
begin
  Selected:=roUser;
end;

procedure TFoProperties.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=True;
  if (ModalResult=mrOK) and (Selected=roUser) then begin
    try
      StrToInt(EdUser.Text);
    except
      Application.MessageBox('Poèet desetinných míst musí být celé èíslo.','Chyba',mb_Ok+mb_IconError);
      EdUser.SetFocus;
      CanClose:=False;
    end;
  end;
end;

end.

