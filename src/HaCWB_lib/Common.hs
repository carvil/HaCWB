module Common (
              , procLength
              , f
              , verifyNameAndNArgs
              , complements
              , my_elem
              , putNew
              , extractActionValues
              ) where

import Data

procLength :: Process a -> Int
procLength (Or a b) = max (procLength a) (procLength b)
procLength (Paralel a b) = (procLength a) + (procLength b)
procLength (Dot a p) = 1 + procLength p
procLength (New l p) = procLength p
procLength Zero = 1
procLength _ = 0

--ok
f :: Eq a 
  => LstProcesses a 
  -> String 
  -> (LstProcesses a -> Process a -> Path a) 
  -> Path a

f l p g = let p' = filter (((==) p) . fst) l
          in if not(null(p')) 
          then g l (snd (head p'))
	  else []

--ok
verifyNameAndNArgs :: Eq a 
                     => Action a 
                     -> Action a 
                     -> Bool

verifyNameAndNArgs (Varinput (a, la)) (Compoutput (b, lb)) = 
                     (a == b) && (length la == length lb)
verifyNameAndNArgs (Compoutput (a, la)) (Varinput (b, lb)) = 
                     (a == b) && (length la == length lb)
verifyNameAndNArgs _                     _                 = 
                     False

--ok
complements ::  Eq a => Action a -> Path a -> Path a
complements (Var a)  l = filter ((== (Comp a)) . fst) l
complements (Comp a) l = filter ((== (Var a)) . fst) l
complements a        l = filter ((verifyNameAndNArgs a) . fst) l

--ok
my_elem :: Eq a 
        => Action a 
        -> [a] 
        -> Bool

my_elem (Var a)  l            = a `elem` l
my_elem (Comp a) l            = a `elem` l
my_elem (Varinput   (a, _)) l = a `elem` l
my_elem (Compoutput (a, _)) l = a `elem` l
my_elem  Tau     _ = False

--ok
putNew _ [] = []
putNew k ((a,b):xs) = (a,(New k b)) : putNew k xs


--ok
extractActionValues :: Action a -> [a]
extractActionValues (Varinput (_,l))   = l
extractActionValues (Compoutput (_,l)) = l
extractActionValues _                  = []

