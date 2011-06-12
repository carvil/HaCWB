{
module TrabLexer (
{- module Main (  -- debug -}
       alexScanTokens,
       Token(..)
) where

}

%wrapper "basic"

$act  = [a-z]
$proc = [A-Za-z0-9]

tokens :-
  $white+ ;
  \<    { \_ -> SYNOutOp } -- CCS Anotado
  \>    { \_ -> SYNOutCl } -- CCS Anotado
  \;    { \_ -> SYNFim }
  "0"   { \_ -> SYNZero }
  \|    { \_ -> SYNParallel }
  \{    { \_ -> SYNOGib }
  \}    { \_ -> SYNCGib }
  \(    { \_ -> SYNOBra }
  \)    { \_ -> SYNCBra }
  \,    { \_ -> SYNComma }
  \~    { \_ -> SYNNot }
  \+    { \_ -> SYNChoice }
  \.    { \_ -> SYNDot }
  \=    { \_ -> SYNEQ }
  [nN][eE][wW]  { \_ -> SYNNew } 
  $act+ { \s -> SYNAct s }
  [A-Z]$proc+ { \s -> SYNProcName s }
{
data Token = SYNZero
     	   | SYNParallel
	   | SYNOGib
	   | SYNCGib
	   | SYNOBra
	   | SYNCBra
	   | SYNComma
	   | SYNNot
	   | SYNChoice
	   | SYNDot
	   | SYNNew
	   | SYNAct String
	   | SYNEQ 
	   | SYNFim
	   | SYNProcName String 
	   | SYNOutOp
	   | SYNOutCl deriving Show

{- debug 
main = do
       s <- getContents
       print (alexScanTokens s)
-}

}
