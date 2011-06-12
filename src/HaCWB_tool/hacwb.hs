module Main where

import System
import System.Console.GetOpt

import IO
import System.IO.Unsafe
import Evaluate
import EvaluateOneStep
import TransG2Graphviz
import Data
import Util
import TrabParser
import TrabLexer
import Char

--------------------------------------------------------------------------------

options :: [OptDescr String]
options = [ Option ['H','h']
                   ["help"]
                   (NoArg "H")
                   "output a brief help message"
          , Option ['L','l']
                   ["load"]
                   (ReqArg ('l':) "file_in")
                   "specify input file"
          , Option ['S','s']
                   ["save"]
                   (ReqArg ('s':) "file_out")
                   "save transition graph"
          , Option ['G','g']
                   ["graph"]
                   (NoArg "G")
                   "generate transition graph"
          , Option ['F','f']
                   ["save"]
                   (NoArg "F")
                   "generate multiple files with transition graphs"
          , Option ['T','t']
                   ["type"]
                   (ReqArg ('t':) "typeEval")
                   "Type of evaluation (ccs/pi)"
          ]

--------------------------------------------------------------------------------

main :: IO ()
main =  
  do args <- getArgs
     let (o,n,errs) = getOpt Permute options args
     let opt  = map (take 1) o
     let arg  = map (drop 1) o
     let opts = zip opt arg
     let errs' = takeUnrecOpts errs
     if ((errs /= []) || ("H" `elem` opt))
        then showErrs errs' options
        else processOptions opt opts 

   where takeUnrecOpts [] = []
         takeUnrecOpts (x:xs) = let x' = drop 22 x
                                in (take 1 x') : takeUnrecOpts xs


--------------------------------------------------------------------------------
--	Se houver erros na chamada da ferramenta, eles são colocados um por 
--	linha, seguidos do menú de ajuda.
--------------------------------------------------------------------------------

showErrs [] opts = do showErrs' [] opts
showErrs l opts = do putStr "\nUnrecognized options: "
                     showErrs' l opts


showErrs' [] opts = putStr ((usageInfo usageheader opts) ++ 
               "\n\nFor more information see README file.\n\n")
  where
    usageheader = "\n\nHaCWB - A Haskell tool to manipulate processes.\n" ++ 
                  "Usage: hacwb options ... \n\nList of options:\n"
showErrs' [x] opts = do putStr x
                        showErrs' [] opts
showErrs' (x:xs) opts = do putStr (x ++ ", ")
                           showErrs' xs opts


--------------------------------------------------------------------------------
--	Processamento da lista de ooções introduzida pelo utilizador.
--------------------------------------------------------------------------------


processOptions :: [String]            --Options list
               -> [(String,String)]   --Pair of option - argument
               -> IO()

processOptions opts l = 
  do case ("G" `elem` opts) of
      True -> case ("l" `elem` opts) of
               True  -> case (lookup "l" l) of
                         Just fin  -> case ("t" `elem` opts) of
                                       True -> case (lookup "t" l) of
                                                Just op -> case ccs_or_pi op of
							    True -> do let cont  = readFile fin
                                                                       let str   = unsafePerformIO cont
                                                                       let lst   = buildLst str
                                                                       let names = map fst lst
                                                                       let temp = (evaluateList op lst)
								       let lst' = map thr' temp
								       putStr ("\n" ++ (show lst') ++ "\n")
								       putStr ("\nfst\n" ++ (show (map fst' temp)) ++ "\n")
								       putStr ("\nsnd\n" ++ (show (map snd' temp)) ++ "\n")
                                                                       case ("s" `elem` opts) of
                                                                        True -> case (lookup "s" l) of
                                                                                 Just fout -> if(lst /= [])
                                                                                              then transg2graphviz2file lst' names fout
                                                                                              else putStr "\nNothing to be done.\n"
                                                                                 Nothing -> putStr "\nhacwb PANIC! The impossible happened|\n"
                                                                        False -> case ("F" `elem` opts) of
                                                                                  True  -> do let fnames = map show [1..length lst']
                                                                                              transglist2graphviz2file lst' fnames
                                                                                  False -> putStr (transg2graphvizall "out" names lst' "")
                                                            False -> putStr error_evalwrong
                                                Nothing -> putStr error_evalreq
                                       False -> do putStr error_evalreq
                         Nothing -> putStr "\nhacwb PANIC! The impossible happened|\n"
               False -> putStr ("\nInput file missing. Try hacwb -h for more information.\n")
      False -> putStr "Unable to build transition graph. Option -g required.\nTry hacwb -h for more information.\n"

buildLst = reconhecedor . alexScanTokens

error_evalreq = "\nUnable to run hacwb. Evaluation type required (ccs or pi). Try hacwb -h for more information.\n"

error_evalwrong = "\nUnable to run hacwb. Evaluation type must be ccs or pi. Try hacwb -h for more information.\n"

ccs_or_pi :: String 
          -> Bool
ccs_or_pi str | str == "ccs" = True
ccs_or_pi str | str == "pi" = True
ccs_or_pi str | otherwise = False
