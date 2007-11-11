{
    Zdrojov� k�d Stroj�rensk�ho kalkul�toru

    Copyright (C) 1997-2001  Ing. Petr Gotthard
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
unit siEditParser;

interface

uses Windows, SysUtils, Classes, Math;

const MaxIdentifierLen = 10;

type TInteFuncti = function( argC: Byte; argV: array of Extended ): Extended;
     TGetFunEvent = procedure( Sender: TObject; FunName: string; var Pointer: TInteFuncti ) of object;
     TGetVarEvent = procedure( Sender: TObject; VarName: string; var Value: Extended; var Found: Boolean ) of object;

type PParameters = ^TParameters;
     TParameters = record
       paValue: Extended;
       paNext: PParameters;
     end;
     { typy termin�ln�ch a nontermin�ln�ch symbol� }
     TSymType = ( syNum, syId, syExpOp, syMulOp, syAddOp,
       syLPr, syRPr, sySem, syEOF, syExpr, syParams );
     { p��pustn� oper�tory }
     TOper = ( opAdd, opSub, opMul, opDiv, opMod, opExp );
     { termin�ln� a nontermin�ln� symboly }
     TSymbol = record
       case SymType: TSymType of
         syNum,syExpr: ( number:Extended );
         syId: ( name:string[MaxIdentifierLen] );
         syExpOp,syMulOp,syAddOp: ( oper:TOper );
         syLPr,syRPr,sySem,syEOF: ();
         syParams: ( params:PParameters );
       end;
     { z�sobn�k }
     PStack = ^TStack;
     TStack = record
       stSymbol: TSymbol;
       stState: word;
       stNext: PStack;
     end;

type EParseException = class( Exception );

type TMathParser = class( TComponent )
     private
       { Private declarations }
       FInput: string;
       FOnGetFun: TGetFunEvent;
       FOnGetVar: TGetVarEvent;
     protected
       { Protected declarations }
       Position: Word;
       Symbol: TSymbol;
       Stack: PStack;
       function NextSymbol: TSymbol;
       procedure Push( Symbol: TSymbol; State: Word );
       procedure Pop(var Symbol: TSymbol);
       procedure Shift( State: Word );
       procedure Reduce( Reduction: Word );
     public
       { Public declarations }
       ParseValue: Extended;
       constructor Create(AOwner: TComponent); override;
       procedure Parse;
     published
       { Published declarations }
       property OnGetFun: TGetFunEvent read FOnGetFun write FOnGetFun;
       property OnGetVar: TGetVarEvent read FOnGetVar write FOnGetVar;
       property ParseString: string read FInput write FInput;
     end;

procedure Register;

{$R *.DCR}

implementation

{
 J�dro implementace tvo�� syntaktick� analyz�tor metodou zdola nahoru
 pro jazyk LR(1).
 Tabulky kone�n�ho automatu byly z definice jazyka v "parstab.y"
 vygenerov�ny programem Bison do "parstab.out" pomoc� p��kazu
 "bison -v parstab.y". Bison je k nalezen� na "ftp://ftp.gnu.cz".
}

{ definice kl��ov�ch slov }
const NumKeywords = 1;
      Keywords: array[0..NumKeywords-1] of record
        kwName: string[MaxIdentifierLen];
        kwSymType: TSymType;
        kwOper: TOper;
      end =
  (( kwName: 'MOD'; kwSymType:syMulOp; kwOper: opMod )); { zbytek po d�len� }

{ definice intern�ch prom�nn�ch }
const NumVariables = 2;
      Variables: array[0..NumVariables-1] of record
        varName: string[MaxIdentifierLen];
        varValue: Extended;
      end =
  (( varName: 'PI'; varValue: 3.1415926535897932384626 ), { ludolfovo ��slo }
   ( varName: 'E'; varValue: 2.7182818284590452353603 )); { z�klad p�irozen�ch logaritm� }

{ definice intern�ch funkc� }
function funAbs( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Abs( argV[0] );
end;
function funArcTan( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := ArcTan( argV[0] );
end;
function funCos( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Cos( argV[0] );
end;
function funRound( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Round( argV[0] );
end;
function funSin( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Sin( argV[0] );
end;
function funSqrt( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Sqrt( argV[0] );
end;
function funSqr( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Sqr( argV[0] );
end;
function funTrunc( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Trunc( argV[0] );
end;
function funArcCos( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := ArcCos( argV[0] );
end;
function funArcCosH( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := ArcCosH( argV[0] );
end;
function funArcSin( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := ArcSin( argV[0] );
end;
function funArcSinH( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := ArcSinH( argV[0] );
end;
function funArcTanH( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := ArcTanH( argV[0] );
end;
function funCosH( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := CosH( argV[0] );
end;
function funCotan( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Cotan( argV[0] );
end;
function funSinH( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := SinH( argV[0] );
end;
function funTan( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Tan( argV[0] );
end;
function funTanH( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := TanH( argV[0] );
end;
function funLn( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Ln( argV[0] );
end;
function funLog( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := Log10( argV[0] );
end;
function funLogN( argC: Byte; argV: array of Extended ): Extended;
begin
  Result := LogN( argV[0], argV[1] );
end;

const NumFunctions = 21;
      Functions: array[0..NumFunctions-1] of record
        funName: string[MaxIdentifierLen];
        funArgs: Short;
        funPointer: TInteFuncti;
      end = (
   ( funName: 'ABS'; funArgs: 1; funPointer: funAbs ),
   ( funName: 'ARCTAN'; funArgs: 1; funPointer: funArcTan ),
   ( funName: 'COS'; funArgs: 1; funPointer: funCos ),
   ( funName: 'ROUND'; funArgs: 1; funPointer: funRound ),
   ( funName: 'SIN'; funArgs: 1; funPointer: funSin ),
   ( funName: 'SQRT'; funArgs: 1; funPointer: funSqrt ),
   ( funName: 'SQR'; funArgs: 1; funPointer: funSqr ),
   ( funName: 'TRUNC'; funArgs: 1; funPointer: funTrunc ),
   ( funName: 'ARCCOS'; funArgs: 1; funPointer: funArcCos ),
   ( funName: 'ARCCOSH'; funArgs: 1; funPointer: funArcCosH ),
   ( funName: 'ARCSIN'; funArgs: 1; funPointer: funArcSin ),
   ( funName: 'ARCSINH'; funArgs: 1; funPointer: funArcSinH ),
   ( funName: 'ARCTANH'; funArgs: 1; funPointer: funArcTanH ),
   ( funName: 'COSH'; funArgs: 1; funPointer: funCosH ),
   ( funName: 'COTAN'; funArgs: 1; funPointer: funCotan ),
   ( funName: 'SINH'; funArgs: 1; funPointer: funSinH ),
   ( funName: 'TAN'; funArgs: 1; funPointer: funTan ),
   ( funName: 'TANH'; funArgs: 1; funPointer: funTanH ),
   ( funName: 'LN'; funArgs: 1; funPointer: funLn ),
   ( funName: 'LOG'; funArgs: 1; funPointer: funLog ),
   ( funName: 'LOGN'; funArgs: 2; funPointer: funLogN ));

{ konstruktor }
constructor TMathParser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInput := '';
  Stack := nil;
end;

{ na�te dal�� symbol ze vstupu }
function TMathParser.NextSymbol: TSymbol;
var tempStr: String;
    Found: Boolean;
    I: Integer;
begin
   { p�esko�en� �vodn�ch mezer }
   while (Position <= Length(FInput)) and (FInput[Position] = ' ') do Inc(Position);
   { kontrola konce vstupu }
   if Position > Length(FInput) then begin
     Result.SymType := syEOF;
     Exit;
   end; { if }

   { na��t�n� ��sla }
   if FInput[Position] in ['0'..'9',DecimalSeparator] then begin
     tempStr := '';
     while (Position <= Length(FInput)) and (FInput[Position] in ['0'..'9']) do begin
       tempStr := tempStr + FInput[Position];
       Inc(Position);
     end; { while }
     { desetinn� ��slo }
     if (Position <= Length(FInput)) and (FInput[Position] in [DecimalSeparator]) then begin
       repeat
         tempStr := tempStr + FInput[Position];
         Inc(Position);
       until (Position > Length(FInput)) or (not (FInput[Position] in ['0'..'9']));
     end;
     { semilogaritmick� tvar }
     if (Position <= Length(FInput)) and (FInput[Position] in ['e','E']) then begin
       tempStr := tempStr + FInput[Position];
       Inc(Position);
       { nepovinn� znam�nko }
       if (Position <= Length(FInput)) and (FInput[Position] in ['+','-','0'..'9']) then begin
         repeat
           tempStr := tempStr + FInput[Position];
           Inc(Position);
         until (Position > Length(FInput)) or (not (FInput[Position] in ['0'..'9']));
       end; { if }
     end; { if }
     Result.SymType := syNum;
     Result.number := StrToFloat( tempStr );
     Exit;
   end else if FInput[Position] in ['A'..'Z','a'..'z'] then begin
     tempStr := '';
     {na��t�n� identifik�toru}
     repeat
       tempStr := tempStr + UpCase( FInput[Position] );
       Inc(Position);
     until (Position > Length(FInput)) or (not (FInput[Position] in
       ['A'..'Z','a'..'z', '0'..'9', '_']));

     Found := False;
     { kontrola kl��ov�ch slov }
     I := 0;
     while ( I < NumKeywords ) and ( not Found ) do begin
       if Keywords[I].kwName = tempStr then begin
         Result.SymType := Keywords[I].kwSymType;
         Result.oper := Keywords[I].kwOper;
         Found := True;
       end;
       Inc( I );
     end;
     { kl��ov� slovo nenalezeno, je to identifik�tor }
     if not Found then begin
       Result.SymType := syId;
       Result.name := tempStr;
     end;
     Exit;
   end else begin
     case FInput[Position] of
       '+': begin Result.oper := opAdd; Result.SymType := syAddOp; end;
       '-': begin Result.oper := opSub; Result.SymType := syAddOp; end;
       '*': begin Result.oper := opMul; Result.SymType := syMulOp; end;
       '/': begin Result.oper := opDiv; Result.SymType := syMulOp; end;
       '^': begin Result.oper := opExp; Result.SymType := syExpOp; end;
       '(': Result.SymType := syLPr;
       ')': Result.SymType := syRPr;
       ';': Result.SymType := sySem;
       else raise EParseException.Create('Neo�ek�van� znak ''' + FInput[Position] + '''');
     end; { case }
     Inc(Position);
     Exit;
   end; { else if }
end; { NextSymbol }

{ vlo�� symbol na z�sobn�k }
procedure TMathParser.Push( Symbol: TSymbol; State: Word );
var Item: PStack;
begin
  { vytvo��me novou polo�ku }
  New( Item );
  with Item^ do begin
    stSymbol := Symbol;
    stState := State;
    stNext := Stack;
  end;
  { nov� vrchol z�sobn�ku }
  Stack := Item;
end;

{ vyzvedne symbol ze z�sobn�ku }
procedure TMathParser.Pop( var Symbol: TSymbol );
var Item: PStack;
begin
  Item := Stack;
  with Item^ do begin
    Symbol := stSymbol;
    { nov� vrchol z�sobn�ku }
    Stack := stNext;
  end;
  { zru��me starou polo�ku }
  Dispose( Item );
end;

{ vlo�� symbol v dan�m stavu na z�sobn�k a na�te dal�� }
procedure TMathParser.Shift( State: Word );
begin
  Push( Symbol, State );
  Symbol := NextSymbol;
end;

{ vezme data ze z�sobn�ku a provede redukci podle dan�ho pravdila }
procedure TMathParser.Reduce( Reduction: Word );
var Value1, Value2, Operator, Output: TSymbol;
    InteFuncti: TInteFuncti;
    FuncParams: array of Extended;
    Param, OldParam: PParameters;
    I: Integer;
    ArgCount: Byte;
    Found: Boolean;
begin
  { vybereme po�adovanou redukci }
  case Reduction of
    1: begin { expr -> expr ADDOP expr }
      Pop( Value2 );
      Pop( Operator );
      Pop( Value1 );
      Output.SymType := syExpr;
      case Operator.oper of
        opAdd: Output.number := Value1.number + Value2.number;
        opSub: Output.number := Value1.number - Value2.number;
      end;
    end;
    2: begin { expr -> expr MULOP expr }
      Pop( Value2 );
      Pop( Operator );
      Pop( Value1 );
      Output.SymType := syExpr;
      case Operator.oper of
        opMul: Output.number := Value1.number * Value2.number;
        opDiv: Output.number := Value1.number / Value2.number;
        opMod: Output.number := Round( Value1.number ) mod Round( Value2.number );
      end;
    end;
    3: begin { expr -> expr EXPOP expr }
      Pop( Value2 );
      Pop( Operator );
      Pop( Value1 );
      Output.SymType := syExpr;
      case Operator.oper of
        opExp: Output.number := Power( Value1.number, Value2.number );
      end;
    end;
    4: begin { expr -> ADDOP expr }
      Pop( Value1 );
      Pop( Operator );
      Output.SymType := syExpr;
      case Operator.oper of
        opAdd: Output.number := + Value1.number;
        opSub: Output.number := - Value1.number;
      end;
    end;
    5: begin { expr -> LPR expr RPR }
      Pop( Operator );
      Pop( Value1 );
      Pop( Operator );
      Output.SymType := syExpr;
      Output.number := Value1.number;
    end;
    6: begin { expr -> NUM }
      Pop( Value1 );
      Output.SymType := syExpr;
      Output.number := Value1.number;
    end;
    7: begin { expr -> ID }
      Pop( Value1 );
      Found := False;
      { hled�me intern� prom�nn� }
      I := 0;
      while ( I < NumVariables ) and ( not Found ) do begin
        { prom�nn� nalezena }
        if( Variables[I].varName = Value1.name ) then begin
          Output.number := Variables[I].varValue;
          Found := True;
        end;
        Inc( I );
      end;
      { zept�me se na dal�� prom�nn� }
      if ( not Found ) and Assigned( FOnGetVar ) then
        FOnGetVar( Self, Value1.name, Output.number, Found );

      if not Found then
        raise EParseException.Create('Nezn�m� prom�nn� ''' + Value1.name + '''');
      Output.SymType := syExpr;
    end;
    8: begin { expr -> ID LPR params RPR }
      Pop( Operator );
      Pop( Value2 );
      Pop( Operator );
      Pop( Value1 );

      ArgCount := 0;
      { spo��t�me parametry }
      Param := Value2.params;
      while Param <> nil do begin
        Param := Param^.paNext;
        Inc( ArgCount );
      end;

      try
        InteFuncti := nil;
        { hled�me intern� funkce }
        I := 0;
        while ( I < NumFunctions ) and ( not Assigned( InteFuncti )) do begin
          { funkce nalezena }
          if( Functions[I].funName = Value1.name ) then begin
            { zkontrolujeme spr�vnost po�tu parametr� }
            if ( Functions[I].funArgs > 0 ) and
               ( Functions[I].funArgs <> ArgCount ) then
              raise EParseException.Create('Chybn� po�et argument� funkce ''' + Value1.name + '''');
            { ulo��me ukazatel }
            InteFuncti := Functions[I].funPointer;
          end;
          Inc( I );
        end;
        { zept�me se na dal�� funkce }
        if ( not Assigned( InteFuncti )) and Assigned( FOnGetFun ) then
          FOnGetFun( Self, Value1.name, InteFuncti );

        { byla funkce nalezena? }
        if Assigned( InteFuncti ) then begin
          SetLength( FuncParams, ArgCount );
          { p�ed�me parametry do pole }
          I := 0;
          Param := Value2.params;
          while Param <> nil do begin
            FuncParams[I] := Param^.paValue;
            Inc( I );
            Param := Param^.paNext;
          end;

          { z�skej hodnotu funkce }
          Output.SymType := syExpr;
          Output.number := InteFuncti( ArgCount, FuncParams );
        end else raise EParseException.Create('Nezn�m� funkce ''' + Value1.name + '''');
      finally
        { zru��me pole parametr� }
        Param := Value2.params;
        while Param <> nil do begin
          OldParam := Param;
          Param := OldParam^.paNext;
          Dispose( OldParam );
        end;
      end;
    end;
    9: begin { params -> expr SEM params }
      Pop( Value2 );
      Pop( Operator );
      Pop( Value1 );
      Output.SymType := syParams;
      { vytvo�en� nov�ho parametru }
      New( Output.params );
      with Output.params^ do begin
        paValue := Value1.number;
        paNext := Value2.params;
      end;
    end;
    10: begin { params -> expr }
      Pop( Value1 );
      Output.SymType := syParams;
      { vytvo�en� nov�ho parametru }
      New( Output.params );
      with Output.params^ do begin
        paValue := Value1.number;
        paNext := nil;
      end;
    end;
  end; { case }

  { z tabulky p�echod� vybereme nov� stav }
  case Output.SymType of
    syExpr: case Stack^.stState of
      0: Push( Output, 5 );
      3: Push( Output, 7 );
      4: Push( Output, 8 );
      6,18: Push( Output, 12 );
      9: Push( Output, 15 );
      10: Push( Output, 16 );
      11: Push( Output, 17 );
    end;
    syParams: case Stack^.stState of
      6: Push( Output, 13 );
      18: Push( Output, 20 );
    end;
  end;
end; { Reduce }

{ vy�e�� matematick� v�raz }
procedure TMathParser.Parse;
var Item: PStack;
    Accepted: Boolean;
begin
  Position := 1;
  Accepted := False;
  try
    { vlo��me na z�sobn�k koncov� symbol }
    Symbol.SymType := syEOF;
    Push( Symbol, 0 );
    { na�teme prvn� symbol }
    Symbol := NextSymbol;
    repeat
      case Stack^.stState of
        0: case Symbol.SymType of
          syNum: Shift(1);
          syId: Shift(2);
          syAddOp: Shift(3);
          syLPr: Shift(4);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        1: Reduce(6);
        2: case Symbol.SymType of
          syLPr: Shift(6);
          else Reduce(7);
        end;
        3: case Symbol.SymType of
          syNum: Shift(1);
          syId: Shift(2);
          syAddOp: Shift(3);
          syLPr: Shift(4);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        4: case Symbol.SymType of
          syNum: Shift(1);
          syId: Shift(2);
          syAddOp: Shift(3);
          syLPr: Shift(4);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        5: case Symbol.SymType of
          syEOF: Accepted := True;
          syExpOp: Shift(9);
          syAddOp: Shift(10);
          syMulOp: Shift(11);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        6: case Symbol.SymType of
          syNum: Shift(1);
          syId: Shift(2);
          syAddOp: Shift(3);
          syLPr: Shift(4);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        7: Reduce(4);
        8: case Symbol.SymType of
          syExpOp: Shift(9);
          syAddOp: Shift(10);
          syMulOp: Shift(11);
          syRPr: Shift(14);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        9: case Symbol.SymType of
          syNum: Shift(1);
          syId: Shift(2);
          syAddOp: Shift(3);
          syLPr: Shift(4);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        10: case Symbol.SymType of
          syNum: Shift(1);
          syId: Shift(2);
          syAddOp: Shift(3);
          syLPr: Shift(4);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        11: case Symbol.SymType of
          syNum: Shift(1);
          syId: Shift(2);
          syAddOp: Shift(3);
          syLPr: Shift(4);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        12: case Symbol.SymType of
          syExpOp: Shift(9);
          syAddOp: Shift(10);
          syMulOp: Shift(11);
          sySem: Shift(18);
          else Reduce(10);
        end;
        13: case Symbol.SymType of
          syRPr: Shift(19);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        14: Reduce(5);
        15: Reduce(3);
        16: case Symbol.SymType of
          syExpOp: Shift(9);
          syMulOp: Shift(11);
          else Reduce(1);
        end;
        17: case Symbol.SymType of
          syExpOp: Shift(9);
          else Reduce(2);
        end;
        18: case Symbol.SymType of
          syNum: Shift(1);
          syId: Shift(2);
          syAddOp: Shift(3);
          syLPr: Shift(4);
          else raise EParseException.Create('Syntaktick� chyba');
        end;
        19: Reduce(8);
        20: Reduce(9);
      end; { case }
    until Accepted;

    { zpracov�n� prob�hlo bez chyby }
    Pop( Symbol );
    ParseValue := Symbol.number;
  finally
    { vypr�zdn�me z�sobn�k }
    while Stack <> nil do begin
      Item := Stack;
      Stack := Item^.stNext;
      Dispose( Item );
    end;
  end;
end; { Parse }

procedure Register;
begin
  RegisterComponents('Additional', [TMathParser]);
end;

end.

