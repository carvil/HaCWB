module Util (
            , removePlica
            , removeAspa
            , showP
            , printP
            , lookup'
            , thr'
            , snd'
            , fst'
            ) where



-------------------------------------------------------------------------------
--	Dado um elemento (processo ou acção), faz-se o show, e retira-se
--	as possiveis plicas e aspas presentes no texto.
-------------------------------------------------------------------------------


showP :: Show a
      => a 
      -> (String -> String)

showP = removePlica . removeAspa . show


-------------------------------------------------------------------------------
--	Retira o(s) caracter(es) "aspa" de uma string dada.
-------------------------------------------------------------------------------


removeAspa :: String -> String
removeAspa l = (filter ((/=) '\"') l)


-------------------------------------------------------------------------------
--	Remove as plicas de uma string.
-------------------------------------------------------------------------------


removePlica :: String -> (String -> String)
removePlica l = (++) (filter ((/=) '\'') l)


-------------------------------------------------------------------------------
--	Dado um processo e uma lista de etiquetas, devolve a etiqueta dess
--	processo. A eiqueta existe de certeza na lista, donde o programa 
--	não atinge o caso de paragem.
-------------------------------------------------------------------------------


lookup' :: Eq p => [(p,Int)] -> p -> Int
lookup' [] _ = -1
lookup' ((a,b):xs) p | p == a = b
                     | otherwise = lookup' xs p




snd' :: (a,b,c) -> b
snd' (_,b,_) = b

fst' :: (a,b,c) -> a
fst' (a,_,_) = a

thr' :: (a,b,c) -> c
thr' (_,_,c) = c


--------------------------------------------------------------------------------
--	Dado uma lista de processos, faz o "show" para IO
--------------------------------------------------------------------------------

printP :: String -> IO ()
printP = putStr . show
