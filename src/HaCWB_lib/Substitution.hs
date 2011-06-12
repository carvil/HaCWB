module Substitution (
                    , subst
                    , subst'
                    , substAct
                    , binded_varsProc
                    ) where

import Data
import Common
 
subst :: (Eq a, Renom a) 
      => LstProcesses a 
      -> [(a,a)] 
      -> Process a 
      -> Process a

subst _ [] p = p
subst lsp ((a,b):xs) p = let bind = binded_varsProc lsp p
                             rename = renom bind b
                             sbst = subst' lsp [] (a,rename) p
                         in subst lsp xs sbst

subst' :: Eq a 
       => LstProcesses a 
       -> [a] 
       -> (a, a) 
       -> Process a 
       -> Process a

subst' lsp lstb s Zero          = Zero
subst' lsp lstb s (Or a b)      = let a' = (subst' lsp lstb s a)
                                      b' = (subst' lsp lstb s b)
                                  in Or a' b'

subst' lsp lstb s (Paralel a b) = let a' = (subst' lsp lstb s a)
                                      b' = (subst' lsp lstb s b)
                                  in Paralel a' b'

subst' lsp lstb s (Dot a p)     = let a' = substAct s a
                                      p' = subst' lsp lstb s p
                                  in Dot a' p'

subst' lsp lstb s (New rest p)  = let p' = subst' lsp (lstb++rest) s p
                                  in New rest p'
subst' lsp lstb s (NameP a)     = 
-- isto parece muitas vezes, rever possibilidade de ser só um
                   let p = filter (((==) a) . fst) lsp
                   in if not(null(p)) 
                      then subst' lsp lstb s (snd (head p))
                      else Zero


substAct :: Eq a 
         => (a, a) 
         -> Action a 
         -> Action a

substAct p Tau = Tau
substAct (p1, p2) (Var a) | a==p1 = Var p2
                          | otherwise = Var a
substAct (p1, p2) (Comp a) | a==p1 = Comp p2
                           | otherwise = Comp a 
substAct (p1, p2) (Varinput (a, l)) | a==p1 = Varinput (p2, (substAct' (p1, p2) l))
                                    | otherwise = Varinput (a, (substAct' (p1, p2) l))
substAct (p1, p2) (Compoutput (a, l)) | a==p1 = Compoutput (p2 ,(substAct' (p1, p2) l))
                                      | otherwise = Compoutput (a ,(substAct' (p1, p2) l))

-- auxiliar deste modulo
substAct' :: Eq a 
          => (a, a) 
          ->[a] 
          -> [a]
substAct' _      []     = []
substAct' (a, b) (x:xs) | a==x = b:xs
                        | otherwise = x:(substAct' (a,b) xs)


binded_varsProc :: Eq a 
                =>  LstProcesses a 
                -> Process a 
                -> [a]

binded_varsProc _   Zero          = []

binded_varsProc lsp (Or a b)      = (binded_varsProc lsp a) ++ 
                                    (binded_varsProc lsp b)

binded_varsProc lsp (Paralel a b) = (binded_varsProc lsp a) ++ 
                                    (binded_varsProc lsp b)

binded_varsProc lsp (Dot a p)     = (extractActionValues a) ++ 
                                    (binded_varsProc lsp p)

binded_varsProc lsp (New rest p)  = rest ++ (binded_varsProc lsp p)
binded_varsProc lsp (NameP a)     =
-- outra vez o mesmo!!
    let p = filter (((==) a) . fst) lsp
    in if not(null(p)) 
       then binded_varsProc lsp (snd (head p))
       else []
