module Examples(
                tst, lst,lst4,
                termo,
                termos,
                termo1,
                termo11,
                termoN2,
                termoN22,
                termo3,
                termoN3,
                termo4,
                termoN4,
                evolhalf31,
                evolhalf32,
                transg1,
                transg2,
                lst1, p1, p2, termog2,lst2, lst3
--                transg2
) where

import Data

---------------------------------------------------------------------------------
--				Termos - exemplos
---------------------------------------------------------------------------------

tst :: Process String
tst =  (((Var "a") `Dot` ((Var "b") `Dot` Zero)) `Or` ((Var "c") `Dot` ((Var "d") `Dot` Zero))) 

lst = [("A",tst)]


-- a.0
termo :: Process String
termo = Dot (Var "a") Zero
termos :: Process String
termos = (Var "a") `Dot` Zero
lst3 = [("A",termos)]

-- a.0 + ~a.0
termo1 :: Process String
termo1 = ((Var "a") `Dot` Zero) `Or` ((Comp "a") `Dot` Zero)
--lst1 = [("A",termo1)]

-- a.0|~a.0
termo11 :: Process String
termo11 = ((Var "a") `Dot` Zero) `Paralel` ((Comp "a") `Dot` Zero)
lst1 = [("A",termo11)]

-- New {a,b} (~a.0 | a.0)
termoN2 :: Process String
termoN2 = New ["a"] (((Comp "a") `Dot` Zero) `Paralel` ((Var "a") `Dot` Zero))

-- New {a} ((a.0 | ~a.0) + b.0)
--termoN2 :: Process (String)
--termoN2 = New ["a"] ((((Var "a") `Dot` Zero) `Paralel` ((Comp "a") `Dot` Zero)) `Or` ((Var "b") `Dot` Zero))
lst4 = [("A",termoN2)]


-- New {a} ((~a.0 + ~a.0) | a.0)
termoN22 :: Process (String)
termoN22 = New ["a"] ((((Comp "a") `Dot` Zero) `Or` ((Comp "a") `Dot` Zero)) `Paralel` ((Var "a") `Dot` Zero))

-- ((a.b.0 + ~a.c.0) | (a.d.0 + ~a.e.0))
termo3 :: Process (String)
termo3 =  (((Var "a") `Dot` ((Var "b") `Dot` Zero)) `Or` ((Comp "a") `Dot` ((Var "c") `Dot` Zero))) 
          `Paralel` 
          (((Var "a") `Dot` ((Var "d") `Dot` Zero)) `Or` ((Comp "a") `Dot` ((Var "e") `Dot` Zero)))
evolhalf31 = [(Var "a",Dot (Var "b") Zero),(Comp "a",Dot (Var "c") Zero)]
evolhalf32 = [(Var "a",Dot (Var "d") Zero),(Comp "a",Dot (Var "e") Zero)]

-- New {a} ((a.b.0 + ~a.c.0) | (a.d.0 + ~a.e.0))
termoN3 :: Process (String)
termoN3 = New ["a"] ((((Var "a") `Dot` ((Var "b") `Dot` Zero)) `Or` ((Comp "a") `Dot` ((Var "c") `Dot` Zero))) 
                     `Paralel` 
                     (((Var "a") `Dot` ((Var "d") `Dot` Zero)) `Or` ((Comp "a") `Dot` ((Var "e") `Dot` Zero)))
                    )

-- ((a.b.0 + ~a.c.0) | (b.d.0 + ~a.e.0))
termo4 :: Process (String)
termo4 = (((Var "a") `Dot` ((Var "b") `Dot` Zero)) `Or` ((Comp "a") `Dot` ((Var "c") `Dot` Zero))) 
          `Paralel` 
          (((Var "b") `Dot` ((Var "d") `Dot` Zero)) `Or` ((Comp "a") `Dot` ((Var "e") `Dot` Zero)))
                    

-- New {a} ((a.b.0 + ~a.c.0) | (b.d.0 + ~a.e.0))
termoN4 :: Process (String)
termoN4 = New ["a", "b"] ((((Var "a") `Dot` ((Var "b") `Dot` Zero)) `Or` ((Comp "a") `Dot` ((Var "c") `Dot` Zero))) 
                     `Paralel` 
                     (((Var "b") `Dot` ((Var "d") `Dot` Zero)) `Or` ((Comp "a") `Dot` ((Var "e") `Dot` Zero)))
                    )


----------------------------------------------------
-- Exemplos de grafos de transicao 
----------------------------------------------------

--transg1 :: TransG (Action String) (Process String)
transg1 = Node Zero []
--transg1 = R 1 (Just (Var "a")) termo [(R 2 Nothing Zero [])]


transg2 = Node termo1 [(Var 'a', Node Zero []),(Comp 'a', Node Zero [])]


p1 = (Var "a") `Dot` (NameP "B")

p2 = (Var "b") `Dot` Zero

--lst1 = [("A",p1),("B",p2)]


-- A = a.A
--termog2 :: Process String
termog2 = (Var "a") `Dot` (NameP "A")
lst2 = [("A",termog2)]
{-
  A = a.A
  a.A
   |(a)
   V
   A
-}
--transg2 :: TransG (Action String) (Process String)
--transg2 = R 1 Nothing termog2 [(R 1 (Just (Var "a")) termog2 [])]
