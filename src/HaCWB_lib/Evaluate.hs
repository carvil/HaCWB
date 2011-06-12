module Evaluate (
                , evaluateList
                , evaluateSt
                , evalSt
                , mkTree
                ) where

import Data
import Util
import List
import Common
import EvaluateOneStep
import TransG2Graphviz
import Control.Monad.State


--------------------------------------------------------------------------------------
--	Funcao que dado uma lista de processos, tenta devolver o grafo de transicoes
--------------------------------------------------------------------------------------

evaluateList mode l | mode == "ccs" = evaluateList' l l eval1stepccs
                    | mode == "pi"  = evaluateList' l l eval1stepPi
                 where evaluateList' _ [] g = []
                       evaluateList' l ((name, proc):xs) g = 
                                        let lth = 100--procLength proc
                                            initSt = (0,[],[])
                                            k = evaluateList' l xs g
                                            h = evaluateSt evalSt initSt l lth name g
                                        in h : k

evalSt _ _ [] _ = do x <- get
                     return x
-- a func g é a eval1step_xxx
evalSt l limit (x:xs) g = do let l1 = g l x
                             st <- get
                             let newSt = (snd' st) ++ l1
                             if ((fst' st) == limit)
                              then evalSt l limit [] g
                              else do modify ( \(a,b,c) -> (a+1 ,newSt, (x, l1) : c) )
                                      let list = xs ++ (map snd newSt)
                                      evalSt l limit list g


evaluateSt f initState l limit p g = let proc = lookup p l
                                     in case proc of
                                         Just x  -> let (a,b,c) = execState (f l limit [x] g) initState
                                                        lst     = dropWhile (((==) []) . snd) c
                                                        tree    = mkTree lst x
                                                    in (a,b,Node x tree)
                                         Nothing -> (-1,[],Node Zero [])


mkTree :: Eq a
        => LstTrees a
        -> Process a
        -> [(Action a, TransG (Action a) (Process a))]

mkTree l p = let val = lookup p l	
             in case val of
                   Just x  -> let x' = map snd x
                                  a  = map fst x
                                  k = zip a x'
                              in (mkNodes l k)
                   Nothing -> []
           where mkNodes _ [] = []
                 mkNodes l ((a,p):xs) = (a,Node p (mkTree l p)) : (mkNodes l xs)
