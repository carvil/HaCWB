{-# OPTIONS -fglasgow-exts -cpp #-}
module TrabParser (
--module Main (  -- debug 
		   reconhecedor
  )
    where 

import TrabLexer
import Data
#if __GLASGOW_HASKELL__ >= 503
import GHC.Exts
#else
import GlaExts
#endif

-- parser produced by Happy Version 1.16

data HappyAbsSyn t7 t9 t10 t11
	= HappyTerminal Token
	| HappyErrorToken Int
	| HappyAbsSyn4 (LstProcesses String)
	| HappyAbsSyn5 (Process String)
	| HappyAbsSyn6 ([String])
	| HappyAbsSyn7 t7
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11

action_0 (28#) = happyShift action_2
action_0 (4#) = happyGoto action_3
action_0 x = happyTcHack x happyReduce_2

action_1 (28#) = happyShift action_2
action_1 x = happyTcHack x happyFail

action_2 (27#) = happyShift action_4
action_2 x = happyTcHack x happyFail

action_3 (30#) = happyAccept
action_3 x = happyTcHack x happyFail

action_4 (25#) = happyShift action_7
action_4 (29#) = happyReduce_4
action_4 (5#) = happyGoto action_5
action_4 (6#) = happyGoto action_6
action_4 x = happyTcHack x happyReduce_6

action_5 (29#) = happyShift action_18
action_5 x = happyTcHack x happyFail

action_6 (15#) = happyShift action_13
action_6 (19#) = happyShift action_14
action_6 (22#) = happyShift action_15
action_6 (26#) = happyShift action_16
action_6 (28#) = happyShift action_17
action_6 (8#) = happyGoto action_9
action_6 (9#) = happyGoto action_10
action_6 (10#) = happyGoto action_11
action_6 (11#) = happyGoto action_12
action_6 x = happyTcHack x happyFail

action_7 (17#) = happyShift action_8
action_7 x = happyTcHack x happyFail

action_8 (26#) = happyShift action_27
action_8 (7#) = happyGoto action_26
action_8 x = happyTcHack x happyFail

action_9 x = happyTcHack x happyReduce_3

action_10 (16#) = happyShift action_24
action_10 (23#) = happyShift action_25
action_10 x = happyTcHack x happyReduce_11

action_11 x = happyTcHack x happyReduce_12

action_12 x = happyTcHack x happyReduce_13

action_13 x = happyTcHack x happyReduce_17

action_14 (15#) = happyShift action_13
action_14 (19#) = happyShift action_14
action_14 (22#) = happyShift action_15
action_14 (26#) = happyShift action_16
action_14 (28#) = happyShift action_17
action_14 (8#) = happyGoto action_23
action_14 (9#) = happyGoto action_10
action_14 (10#) = happyGoto action_11
action_14 (11#) = happyGoto action_12
action_14 x = happyTcHack x happyFail

action_15 (26#) = happyShift action_22
action_15 x = happyTcHack x happyFail

action_16 (19#) = happyShift action_20
action_16 (24#) = happyShift action_21
action_16 x = happyTcHack x happyFail

action_17 x = happyTcHack x happyReduce_18

action_18 (28#) = happyShift action_2
action_18 (4#) = happyGoto action_19
action_18 x = happyTcHack x happyReduce_2

action_19 x = happyTcHack x happyReduce_1

action_20 (26#) = happyShift action_37
action_20 (12#) = happyGoto action_36
action_20 x = happyTcHack x happyFail

action_21 (15#) = happyShift action_13
action_21 (22#) = happyShift action_15
action_21 (26#) = happyShift action_16
action_21 (28#) = happyShift action_17
action_21 (11#) = happyGoto action_35
action_21 x = happyTcHack x happyFail

action_22 (13#) = happyShift action_33
action_22 (24#) = happyShift action_34
action_22 x = happyTcHack x happyFail

action_23 (20#) = happyShift action_32
action_23 x = happyTcHack x happyFail

action_24 (15#) = happyShift action_13
action_24 (19#) = happyShift action_14
action_24 (22#) = happyShift action_15
action_24 (26#) = happyShift action_16
action_24 (28#) = happyShift action_17
action_24 (9#) = happyGoto action_31
action_24 (10#) = happyGoto action_11
action_24 (11#) = happyGoto action_12
action_24 x = happyTcHack x happyFail

action_25 (15#) = happyShift action_13
action_25 (19#) = happyShift action_14
action_25 (22#) = happyShift action_15
action_25 (26#) = happyShift action_16
action_25 (28#) = happyShift action_17
action_25 (9#) = happyGoto action_30
action_25 (10#) = happyGoto action_11
action_25 (11#) = happyGoto action_12
action_25 x = happyTcHack x happyFail

action_26 (18#) = happyShift action_29
action_26 x = happyTcHack x happyFail

action_27 (21#) = happyShift action_28
action_27 x = happyTcHack x happyReduce_8

action_28 (26#) = happyShift action_27
action_28 (7#) = happyGoto action_42
action_28 x = happyTcHack x happyFail

action_29 x = happyTcHack x happyReduce_5

action_30 x = happyTcHack x happyReduce_9

action_31 x = happyTcHack x happyReduce_10

action_32 x = happyTcHack x happyReduce_14

action_33 (26#) = happyShift action_37
action_33 (12#) = happyGoto action_41
action_33 x = happyTcHack x happyFail

action_34 (15#) = happyShift action_13
action_34 (22#) = happyShift action_15
action_34 (26#) = happyShift action_16
action_34 (28#) = happyShift action_17
action_34 (11#) = happyGoto action_40
action_34 x = happyTcHack x happyFail

action_35 x = happyTcHack x happyReduce_15

action_36 (20#) = happyShift action_39
action_36 x = happyTcHack x happyFail

action_37 (21#) = happyShift action_38
action_37 x = happyTcHack x happyReduce_21

action_38 (26#) = happyShift action_37
action_38 (12#) = happyGoto action_45
action_38 x = happyTcHack x happyFail

action_39 (24#) = happyShift action_44
action_39 x = happyTcHack x happyFail

action_40 x = happyTcHack x happyReduce_16

action_41 (14#) = happyShift action_43
action_41 x = happyTcHack x happyFail

action_42 x = happyTcHack x happyReduce_7

action_43 (24#) = happyShift action_47
action_43 x = happyTcHack x happyFail

action_44 (15#) = happyShift action_13
action_44 (22#) = happyShift action_15
action_44 (26#) = happyShift action_16
action_44 (28#) = happyShift action_17
action_44 (11#) = happyGoto action_46
action_44 x = happyTcHack x happyFail

action_45 x = happyTcHack x happyReduce_22

action_46 x = happyTcHack x happyReduce_19

action_47 (15#) = happyShift action_13
action_47 (22#) = happyShift action_15
action_47 (26#) = happyShift action_16
action_47 (28#) = happyShift action_17
action_47 (11#) = happyGoto action_48
action_47 x = happyTcHack x happyFail

action_48 x = happyTcHack x happyReduce_20

happyReduce_1 = happyReduce 5# 4# happyReduction_1
happyReduction_1 ((HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (SYNProcName happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 ((happy_var_1, happy_var_3):happy_var_5
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_0  4# happyReduction_2
happyReduction_2  =  HappyAbsSyn4
		 ([]
	)

happyReduce_3 = happySpecReduce_2  5# happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (if happy_var_1==[] then happy_var_2 else (New happy_var_1 happy_var_2)
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_0  5# happyReduction_4
happyReduction_4  =  HappyAbsSyn5
		 (Zero
	)

happyReduce_5 = happyReduce 4# 6# happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (happy_var_3
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_0  6# happyReduction_6
happyReduction_6  =  HappyAbsSyn6
		 ([]
	)

happyReduce_7 = happySpecReduce_3  7# happyReduction_7
happyReduction_7 (HappyAbsSyn7  happy_var_3)
	_
	(HappyTerminal (SYNAct happy_var_1))
	 =  HappyAbsSyn7
		 (happy_var_1:happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7# happyReduction_8
happyReduction_8 (HappyTerminal (SYNAct happy_var_1))
	 =  HappyAbsSyn7
		 ([happy_var_1]
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  8# happyReduction_9
happyReduction_9 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn5
		 (Or happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  8# happyReduction_10
happyReduction_10 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn5
		 (Paralel happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  8# happyReduction_11
happyReduction_11 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  9# happyReduction_12
happyReduction_12 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  9# happyReduction_13
happyReduction_13 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  10# happyReduction_14
happyReduction_14 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (happy_var_2
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  11# happyReduction_15
happyReduction_15 (HappyAbsSyn11  happy_var_3)
	_
	(HappyTerminal (SYNAct happy_var_1))
	 =  HappyAbsSyn11
		 (Dot (Var happy_var_1) happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happyReduce 4# 11# happyReduction_16
happyReduction_16 ((HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (SYNAct happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Dot (Comp happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_1  11# happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn11
		 (Zero
	)

happyReduce_18 = happySpecReduce_1  11# happyReduction_18
happyReduction_18 (HappyTerminal (SYNProcName happy_var_1))
	 =  HappyAbsSyn11
		 (NameP happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happyReduce 6# 11# happyReduction_19
happyReduction_19 ((HappyAbsSyn11  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (SYNAct happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Dot (Varinput (happy_var_1, happy_var_3)) happy_var_6
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 7# 11# happyReduction_20
happyReduction_20 ((HappyAbsSyn11  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (SYNAct happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Dot (Compoutput (happy_var_2, happy_var_4)) happy_var_7
	) `HappyStk` happyRest

happyReduce_21 = happySpecReduce_1  12# happyReduction_21
happyReduction_21 (HappyTerminal (SYNAct happy_var_1))
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  12# happyReduction_22
happyReduction_22 (HappyAbsSyn6  happy_var_3)
	_
	(HappyTerminal (SYNAct happy_var_1))
	 =  HappyAbsSyn6
		 (happy_var_1:happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 30# 30# notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	SYNOutOp -> cont 13#;
	SYNOutCl -> cont 14#;
	SYNZero -> cont 15#;
	SYNParallel -> cont 16#;
	SYNOGib -> cont 17#;
	SYNCGib -> cont 18#;
	SYNOBra -> cont 19#;
	SYNCBra -> cont 20#;
	SYNComma -> cont 21#;
	SYNNot -> cont 22#;
	SYNChoice -> cont 23#;
	SYNDot -> cont 24#;
	SYNNew -> cont 25#;
	SYNAct happy_dollar_dollar -> cont 26#;
	SYNEQ -> cont 27#;
	SYNProcName happy_dollar_dollar -> cont 28#;
	SYNFim -> cont 29#;
	_ -> happyError' (tk:tks)
	}

happyError_ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [Token] -> HappyIdentity a
happyError' = HappyIdentity . happyError

reconhecedor tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
{-# LINE 1 "GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command line>" #-}
{-# LINE 1 "GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 28 "GenericTemplate.hs" #-}








{-# LINE 49 "GenericTemplate.hs" #-}

{-# LINE 59 "GenericTemplate.hs" #-}

{-# LINE 68 "GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is 1#, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 1# tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	(happyTcHack j ) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int# ->                    -- token number
         Int# ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 1# tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (I# (i)) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 1# tk st sts stk
     = happyFail 1# tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 1# tk st sts stk
     = happyFail 1# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 1# tk st sts stk
     = happyFail 1# tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 1# tk st sts stk
     = happyFail 1# tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 1# tk st sts stk
     = happyFail 1# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k -# (1# :: Int#)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn 1# tk st sts stk
     = happyFail 1# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn 1# tk st sts stk
     = happyFail 1# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk





             new_state = action


happyDrop 0# l = l
happyDrop n ((_):(t)) = happyDrop (n -# (1# :: Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n -# (1#::Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 253 "GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (1# is the error token)

-- parse error if we are in recovery and we fail again
happyFail  1# tk old_st _ stk =
--	trace "failing" $ 
    	happyError_ tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  1# tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action 1# 1# tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action 1# 1# tk (HappyState (action)) sts ( (HappyErrorToken (I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 317 "GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
