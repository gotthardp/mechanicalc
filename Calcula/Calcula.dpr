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
program Calcula;

uses
  Forms,
  SysUtils,
  MainForm in 'MainForm.pas' {CalcMain},
  AboutBox in 'AboutBox.pas' {AboutBox},
  LibCommon in 'Library\LibCommon.pas' {LibCommon},
  LibProfI in 'Library\LibProfI.pas' {ProfI},
  LibProfLr in 'Library\LibProfLr.pas' {ProfLr},
  LibProfLn in 'Library\LibProfLn.pas' {ProfLn},
  LibProfU in 'Library\LibProfU.pas' {ProfU},
  LibSrouby in 'Library\LibSrouby.pas' {Srouby},
  LibMatice in 'Library\LibMatice.pas' {Matice},
  LibPodlozky in 'Library\LibPodlozky.pas' {Podlozky},
  LibCtverec in 'Library\LibCtverec.pas' {Ctverec},
  LibObdelnik in 'Library\LibObdelnik.pas' {Obdelnik},
  LibKuzel in 'Library\LibKuzel.pas' {Kuzel},
  LibKomoly in 'Library\LibKomoly.pas' {Komoly},
  LibKvadr in 'Library\LibKvadr.pas' {Kvadr},
  LibPlech in 'Library\LibPlech.pas' {Plech},
  LibSestihran in 'Library\LibSestihran.pas' {Sestihran},
  LibTrubka in 'Library\LibTrubka.pas' {Trubka},
  LibValec in 'Library\LibValec.pas' {Valec},
  LibProdlouzeni in 'Library\LibProdlouzeni.pas' {Prodlouzeni},
  LibKroutici in 'Library\LibKroutici.pas' {Kroutici};

{$R *.RES}

begin
  Application.Initialize;
  Application.Name := 'Calcula';
  Application.Title := 'Strojírenský kalkulátor';
  Application.HelpFile := {ExtractFilePath(ParamStr(0))+}'Calcula.hlp';
  Application.CreateForm(TCalcMain, CalcMain);
  Application.Run;
end.
