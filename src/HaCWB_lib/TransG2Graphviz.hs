module TransG2Graphviz (
                       , buildTree
                       , mkList
                       , mkConections
                       , length'
                       , transg2graphviz2file
                       , transglist2graphviz2file
                       , transg2graphviz
                       , transg2graphvizall
                       , takeL
                       , takeP
                       ) where


import Data
import List
import Examples
import Util


--------------------------------------------------------------------------------
--	Funcao que dada uma arvore, escreve para ficheiro o codigo graphviz 
--	equivalente
--------------------------------------------------------------------------------

transglist2graphviz2file :: (Show a, Show p, Eq p)
                     => [TransG a p]
                     -> [String]
                     -> IO()

transglist2graphviz2file [] [] = do putStr "\nDone.\n"
transglist2graphviz2file (tree:trees) (out:outs) = do let cod = transg2graphviz out tree ""
                                                      writeFile (out++".dot") cod
                                                      transglist2graphviz2file trees outs


--------------------------------------------------------------------------------
--	Funcao que dada uma arvore, escreve para ficheiro o codigo graphviz 
--	equivalente
--------------------------------------------------------------------------------

transg2graphviz2file :: (Show a, Show p, Eq p)
                     => [TransG a p]
                     -> [String]
                     -> String
                     -> IO()

transg2graphviz2file trees names out = do let cod = transg2graphvizall out names trees ""
                                          writeFile (out++".dot") cod


--------------------------------------------------------------------------------
--	Funcao que dada uma arvore, gera codigo graphviz equivalente
--------------------------------------------------------------------------------


transg2graphvizall :: (Show a, Show p, Eq p) 
                => String
                -> [String]
                -> [TransG a p]
                -> (String -> String)

transg2graphvizall name names l = showString "digraph " .
                                  showString (change name) .
                                  showString " {\n " .
                                  showTreesPerLine 1 names l

              where showTreesPerLine _ _ [] = showString "\n}\n"
                    showTreesPerLine n (name:ys) (x:xs) = let k = length' x
                                                              m = showTreesPerLine (k+n+1) ys xs
                                                          in showString "subgraph " .
                                                             shows name .
                                                             showString "{\n " .
                                                             buildTree n x . 
                                                             showString " label = " .
                                                             shows name .
                                                             showString "\n}\n" . m

                    change [] = []
                    change (x:xs) | x == '.' = change xs
                                  | otherwise = x : change xs


--------------------------------------------------------------------------------
--	Funcao que dada uma arvore, gera codigo graphviz equivalente
--------------------------------------------------------------------------------


transg2graphviz :: (Show a, Show p, Eq p) 
                => String
                -> TransG a p
                -> (String -> String)

transg2graphviz name tree = showString "digraph " .
                            showString name .
                            showString " {\n " .
                            buildTree 1 tree .
                            showString "\n}\n"


-------------------------------------------------------------------------------
--	Dada uma arvore, esta funcao controi os nodos
-------------------------------------------------------------------------------


buildTree :: (Show a, Show p, Eq p)
          => Int
          -> TransG a p 
          -> (String -> String)

buildTree n tree = let k  = mkList tree [] n
                       k' = ((nub' []) . nub) k
                       q  = mkConections k' tree
                       str_nodes = buildNodes k' ""
                       str_conec = buildConections q ""
                   in showString str_nodes .
                      showString str_conec

                   where buildNodes :: Show p => [(p,Int)] -> String -> String
                         buildNodes [] = showString "\n\n "
                         buildNodes ((a,b):xs) = showP b .
                                                 showString " [shape = box, label = \"" . 
                                                 showP a .
                                                 showString "\", color = white]; \n " .
                                                 buildNodes xs

                         buildConections :: Show a => [(Int,a,Int)] -> String -> String
                         buildConections [] = showString "\n\n "
                         buildConections ((p1,a,p2):xs) = showString (show p1) .
                                                          showString " -> " .
                                                          showP p2 .
                                                          showString " [label = \"" .
                                                          showP a .
                                                          showString "\"];\n " .
                                                          buildConections xs

                         nub' _ [] = []
                         nub' l ((x,y):xs) | x `elem` l = nub' l xs
                                           | otherwise  = (x,y) : (nub' (x : l) xs)


mkList :: Eq p
       => TransG a p 
       -> [(p,Int)]
       -> Int
       -> [(p,Int)]

mkList (Node p l) k i = mkList' l ((p,i):k) (i+1)
                   where mkList' [] k _ = k
                         mkList' ((_,p'):xs) k i = let len = length' p'
                                                   in (mkList p' k i) ++ (mkList' xs k (i+1+len))


mkConections :: Eq p 
             => [(p,Int)]
             -> TransG a p
             -> [(Int,a,Int)]

mkConections k (Node p l) = let l'  = map snd l
                                p'  = map takeP l'
                                act = map fst l
                                n = length l
                                n1 = lookup' k p
                                ns1 = replicate n n1
                                ns2 = map (lookup' k) p'
                                ls  = zip3 ns1 act ns2
                            in ls ++ (concat (map (mkConections k) l'))

-------------------------------------------------------------------------------
--	Dado um grafo de transições, devolve o processo que se encontra na sua
--	raiz.
-------------------------------------------------------------------------------


takeP :: TransG a p -> p
takeP (Node p _) = p


-------------------------------------------------------------------------------
--	Dado um grafo de transições, devolve a lista de evoluções num passo 
--	a partir do processo na raiz do nodo.
-------------------------------------------------------------------------------


takeL (Node p l) = l


-------------------------------------------------------------------------------
--	Dado um grafo de transições, diz a profundidade do grafo.
-------------------------------------------------------------------------------


length' :: TransG a p -> Int
length' (Node p []) = 0
length' (Node p l) = let k = map snd l
                     in (length l) + (sum (map length' k))


