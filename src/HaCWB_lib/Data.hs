module Data (
            , Process(..)
            , Action(..)
            , TransG(..)
            , Path
            , LstTrees
            , Stt
            , LstProcesses
            , Renom
            , renom
            ) where

import Util

---------------------------------------------------------------------------------
--Tipo de dados que define um processo, com os seguintes operadores:
---------------------------------------------------------------------------------
--	-> +  - representa o "ou" entre os termos;
--	-> |  - operador de computacao paralela;
--	-> .  - representa o "apos" entre termos;
--	-> Simbolos - todos os simbolos usados para definir uma 
--	   operacao (a, 0, etc), e ainda o complementar dos simbolos.
---------------------------------------------------------------------------------


data Process a = Or (Process a)  (Process a)
	       | Paralel (Process a) (Process a)
	       | Dot (Action a) (Process a)
	       | Zero 
               | New [a] (Process a)
               | NameP String


---------------------------------------------------------------------------------
--Tipo de dados que define as operacoes (valores simbolicos) a realizar 
--na execucao de um processo.
---------------------------------------------------------------------------------
--	-> Sao considerados valores simbolicos: a, -a (complementar de a), 0, etc
---------------------------------------------------------------------------------

data Action a = Var a 
	      | Comp a 
	      | Tau
              | Varinput   (a,[a])     -- Varinput(a,x)     a(x)
              | Compoutput (a,[a])  --deriving Show -- Compoutput(a,x)  ~a<x> --              | Compinput  (a,[a])    -- Compinput(a,x)   ~a(x)
--              | Varoutput  (a,[a])    -- Varoutpu(a,x)     a<X>

    

---------------------------------------------------------------------------------
--	Tipo do grafo de transicoes
---------------------------------------------------------------------------------


data TransG a p = Node p [(a,TransG a p)]


---------------------------------------------------------------------------------
--	Lista de processos
---------------------------------------------------------------------------------


type LstProcesses a = [(String, Process a)]


---------------------------------------------------------------------------------
--	Lista de arvores para construir o grafo de transicoes	
---------------------------------------------------------------------------------


type LstTrees a = [(Process a, Path a)]


---------------------------------------------------------------------------------
--	Lista de caminhos de uma árvore
---------------------------------------------------------------------------------


type Path a = [(Action a, Process a)]


---------------------------------------------------------------------------------
--	Estado da avaliacao de um processo - limite, lista de caminhos e
--	lista de arvores para construir um grafo de transicoes
---------------------------------------------------------------------------------


type Stt a = (Int, Path a, LstTrees a)

---------------------------------------------------------------------------------
-- Classe para garantir a função de renomeação 
--------------------------------------------------------------------------------
{-Recebe: - lista dos nomes ligados
          - nome da var
 return: novo nome se for preciso ou o antigo-}

class Renom a  where
    renom :: [a] -> a -> a

{-Recebe: - lista dos nomes ligados
          - nome da var
 return: novo nome se for preciso ou o antigo-}
instance Renom String where
    renom l a = if(not(a `elem` l))
                then a
                else renom l (a ++ show (length a))


---------------------------------------------------------------------------------
--			Instancias da classe Eq
---------------------------------------------------------------------------------


instance Eq a => Eq (Action a)  where
    (Var a)               == (Var b)              = a == b
    (Comp a)              == (Comp b)             = a == b
    (Varinput   (a, la))  == (Varinput   (b, lb)) = (a == b) && (la == lb)
--    (Compinput  (a, la))  == (Compinput  (b, lb)) = (a == b) && (la == lb)
--    (Varoutput  (a, la))  == (Varoutput  (b, lb)) = (a == b) && (la == lb)
    (Compoutput (a, la))  == (Compoutput (b, lb)) = (a == b) && (la == lb)
    _                     == _                    = False
    {- Rever se o Tau tb entra aqui -}


instance Eq a => Eq (Process a) where
    (Or a b)      == (Or c d)       = (a == c) && (b == d)
    (Paralel a b) == (Paralel c d)  = (a == c) && (b == d)
    (Dot a p1)    == (Dot b p2)     = (a == b) && (p1 == p2)
    Zero          == Zero           = True
    (New a p1)    == (New b p2)     = (a == b) && (p1 == p2)
    NameP s1      == NameP s2       = s1 == s2
    _             == _              = False


---------------------------------------------------------------------------------
--			Instancias da classe Show
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--Instancia dos Termos para a classe Show
---------------------------------------------------------------------------------
instance Show a => Show (Process a) where
	showsPrec p (Or a b)      = showChar '(' .
                                    showP a . 
                                    showString " + " . 
                                    showP b . 
                                    showChar ')'
	showsPrec p (Paralel a b) = showChar '(' .
                                    showP a . 
                                    showChar '|' .  
                                    showP b .
                                    showChar ')'
	showsPrec p (Dot a b)     = showP a . 
                                    showChar '.' . 
                                    showP b
	showsPrec p (Zero)        = showChar '0'
	showsPrec p (New l a)     = showString "New {" .
                                    (removePlica . removeAspa . show_res_elems) l .
                                    showString "} (" .
                                    showP a .
                                    showChar ')'
        showsPrec p (NameP s)     = showP s


show_res_elems :: Show a => [a] -> String
show_res_elems []      = ""
show_res_elems [x]     = show x
show_res_elems (x:xs)  = show x ++ "," ++ show_res_elems xs


---------------------------------------------------------------------------------
--Instancia dos Simbolos para a classe Show
--	-> ~ representa accao complementar
--	-> # representa tau
---------------------------------------------------------------------------------

instance Show a => Show (Action a) where
	showsPrec p (Var a)           = showP a
	showsPrec p (Comp a)          = showChar '~' .
                                        showP a
	showsPrec p Tau               = showString "#" 
        showsPrec p (Varinput (a, b)) = showP a .
                                        showChar '(' .
                                        (removePlica . removeAspa . show_res_elems) b .
                                        showChar ')'
{-        showsPrec p (Compinput (a, b)) = showChar '~' .
                                        showP a .
                                        showChar '(' .
                                        (removePlica . removeAspa . show_res_elems) b .
                                        showChar ')'
        showsPrec p (Varoutput (a,b)) = showP a .
                                        showChar '<' .
                                        (removePlica . removeAspa . show_res_elems) b .
                                        showChar '>'-}
        showsPrec p (Compoutput (a, b)) = showChar '~' .
                                        showP a .
                                        showChar '<' .
                                        (removePlica . removeAspa . show_res_elems) b .
                                        showChar '>'


---------------------------------------------------------------------------------
--Instancia de Show para um grafo de transicao
---------------------------------------------------------------------------------


instance (Show a, Show p) => Show (TransG a p) where
	showsPrec p (Node pro l) = shows pro . showString " -> " . showList l . showString "\n"


