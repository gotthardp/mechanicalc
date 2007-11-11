%{

%}

%term NUM ID 
%term EXPOP ADDOP MULOP UNOP
%term LPR RPR SEM

%left     ADDOP
%left     MULOP
%left     EXPOP
%right    UNOP

%start    expr
%%

expr:
   expr ADDOP expr
 | expr MULOP expr
 | expr EXPOP expr
 | ADDOP expr %prec UNOP
 | LPR expr RPR
 | NUM
 | ID
 | ID LPR params RPR
;

params:
   expr SEM params
 | expr
;

%%
