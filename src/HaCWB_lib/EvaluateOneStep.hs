module EvaluateOneStep (
		 eval1stepccs,
                 eval1stepPi,
                 buildTau, 
                 constTau,
                       ) where

import Data
import Util
import List
import Common
import Substitution

{--------------------------------------------------------
------------------       CCS        ---------------------
--------------------------------------------------------}

eval1stepccs :: Eq a 
             => LstProcesses a 
             -> Process a 
             -> Path a

eval1stepccs l (Or a b)      = (eval1stepccs l a) ++ 
                               (eval1stepccs l b)
eval1stepccs l (Dot a b)     = [(a,b)]
eval1stepccs l Zero          = [] 
eval1stepccs l (NameP a)     = f l a eval1stepccs

eval1stepccs l (New a b)     = 
                      let evalb = eval1stepccs l b
                          l'    = putNew a evalb
                      in filter (not . (`my_elem` a) . fst) l'

eval1stepccs l (Paralel a b) = 
                      let evala = eval1stepccs l a
                          evalb = eval1stepccs l b
                          taus  = buildTau evala evalb 
                          lista = [(x, y `Paralel` b) | (x,y) <- evala] 
                          listb = [(x, a `Paralel` y) | (x,y) <- evalb]
                      in lista ++ listb ++ taus

        where
          -- tenta construir os taus recebendo a lista de evolucoes esquerda e direita
          -- para cada elem da primeira, ir buscar os comps da segunda
          buildTau :: Eq a => Path a -> Path a -> Path a
          buildTau []     _  = []
          buildTau _      [] = []
          buildTau (x:xs) l  = 
              let act  = fst x
                  proc = snd x
                  compLadoDir = complements act l
                  pD = map snd compLadoDir -- retira o sub-processo de dentro dos Paths
              in ([(Tau, Paralel proc a) | a <- pD]) ++ buildTau xs l


{--------------------------------------------------------
------------------    Pi-Calculus    --------------------
--------------------------------------------------------}
eval1stepPi :: (Eq a, Renom a) 
            => LstProcesses a 
            -> Process a 
            -> Path a

eval1stepPi l (Or a b)      = (eval1stepPi l a) ++ 
                              (eval1stepPi l b)
eval1stepPi _ (Dot a b)     = [(a,b)]
eval1stepPi _ Zero          = [] 
eval1stepPi l (NameP a)     = f l a eval1stepPi

eval1stepPi l (New a b)     = 
                       let evalb = eval1stepPi l b
                           l'    = putNew a evalb
                       in filter (not . (`my_elem` a) . fst) l' 

eval1stepPi l (Paralel a b) = 
                       let evala = eval1stepPi l a
                           evalb = eval1stepPi l b
                           taus  = buildTau l evala evalb
                           lista = [(x, y `Paralel` b) | (x,y) <- evala] 
                           listb = [(x, a `Paralel` y) | (x,y) <- evalb]
                       in lista ++ listb ++ taus
  --      where
          -- tenta construir os taus recebendo a lista de evolucoes esquerda e direita
          -- para cada elem da primeira, ir buscar os comps da segunda
buildTau :: (Eq a, Renom a) 
         => LstProcesses a 
         -> Path a 
         -> Path a 
         -> Path a
buildTau _   []     _  = []
buildTau _   _      [] = []
buildTau lsp (x:xs) d  = 
    let act  = fst x -- acção do lado esquerdo
        proc = snd x -- processo do lado esquerdo
        compLadoDir = complements act d -- lista dos complementares do lado direito
    in (constTau lsp act proc compLadoDir) ++ buildTau lsp xs d

constTau :: (Eq a, Renom a) 
         => LstProcesses a 
         -> Action a 
         -> Process a 
         -> Path a 
         -> Path a
constTau _    _                   _    []      = []
constTau lsp (Varinput (a, args)) proc compsDir = {- subst no lado esquerdo -}
                   [(Tau, Paralel (subst lsp (zip args (extractActionValues x)) proc) p) | (x,p) <- compsDir]
constTau lsp (Compoutput (a, args)) proc compsDir = {- subst no lado direito -}
                   [(Tau, Paralel proc (subst lsp (zip (extractActionValues x) args) p)) | (x,p) <- compsDir] -- ~a<x>
constTau  _ _ proc compsDir = [(Tau, Paralel proc (snd x)) | x <- compsDir] {- REVER para NameP -}
