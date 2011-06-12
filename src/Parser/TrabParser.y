{
module TrabParser (
--module Main (  -- debug 
		   reconhecedor
  )
    where 

import TrabLexer
import Data
}

%name reconhecedor
%tokentype { Token }

%token
'<'  { SYNOutOp } -- CCS Anotado
'>'  { SYNOutCl } -- CCS Anotado
'0'  { SYNZero }
'|'  { SYNParallel }
'{'  { SYNOGib }
'}'  { SYNCGib }
'('  { SYNOBra }
')'  { SYNCBra }
','  { SYNComma }
'~'  { SYNNot }
'+'  { SYNChoice }
'.'  { SYNDot }
NEW  { SYNNew }
ACT  { SYNAct $$ } 
'='  { SYNEQ }
PROCNAME { SYNProcName $$ }
';'  { SYNFim }
%%

Root :: { LstProcesses String }
Root : PROCNAME '=' Process ';' Root  { ($1, $3):$5 }
     | {- empty -} { [] }

Process :: {  Process String }
Process : Rests Proc_Body { if $1==[] then $2 else (New $1 $2) }
     | {- empty -} { Zero }

{- Restricoes -}
Rests :: { [String] }
Rests : NEW '{' More_Rests '}' { $3 }
      | {- empty -} { [] }
More_Rests : ACT ',' More_Rests { $1:$3 }
           | ACT { [$1] }

{- Corpo do Processo -}
Proc_Body :: { Process String }
Proc_Body : Pro '+' Pro { Or $1 $3 }
        | Pro '|' Pro { Paralel $1 $3 } 
        | Pro { $1 }
Pro : Pro_Complex { $1 }
    | P { $1 }
Pro_Complex : '(' Proc_Body ')'{ $2 }
P : ACT '.' P { Dot (Var $1) $3 }
  | '~' ACT '.' P { Dot (Comp $2) $4 }
  | '0' { Zero }
  | PROCNAME {NameP $1}
  | ACT '(' LstAct ')' '.' P { Dot (Varinput ($1, $3)) $6 }      -- Falta por numeros
--  | '~' ACT '(' LstAct ')' '.' P { Dot (Compinput ($2, $4)) $7 } -- Falta por numeros
--  | ACT '<' LstAct '>' '.' P { Dot (Varoutput ($1, $3)) $6 }     -- Falta por numeros
  | '~' ACT '<' LstAct '>' '.' P { Dot (Compoutput ($2, $4)) $7 } -- Falta por numeros
LstAct :: {[String]}
LstAct : ACT       { [$1] }
  | ACT ',' LstAct { $1:$3 }

{
happyError :: [Token] -> a
happyError _ = error "HAPPY: Parse Error"


  {-
main = getContents >>= print . reconhecedor . alexScanTokens 
main = do
    s <- getContents
      print(rec(alexScanTokens s)) 

  | ACT '(' ACT ')' '.' P { Dot (Varinput ($1, $3)) $6 }      -- Falta por numeros
  | '~' ACT '(' ACT ')' '.' P { Dot (Compinput ($2, $4)) $7 } -- Falta por numeros
  | ACT '<' ACT '>' '.' P { Dot (Varoutput ($1, $3)) $6 }     -- Falta por numeros
  | '~' ACT '<' ACT '>' '.' P { Dot (Compoutput ($2, $4)) $7 } -- Falta por numeros
-}

}
