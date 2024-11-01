module Module.PrintSudoku(printProblem, printSolution, printAllSolutions) where

import Types.SudokuTypes ( Form(..), Clause(Or), Literal(P), (<&&>) )

import Data.Char(intToDigit)
import Data.List (intercalate, intersperse)
import Module.DPLL (dpll)


toLiterals :: Form atom -> [Literal atom]
toLiterals (And clauses) = concatMap unpack clauses
    where unpack (Or literals) = literals
                                 
showSquares :: [Literal (Int,Int,Int)] -> String
showSquares lits =
  let pos = [ a | P a <- lits ]
  in
   [ (intToDigit.last) [ k | k <-[0..9]
                       , (i, j, k)`elem`pos || k == 0 ]
   | i <- [1..9], j <- [1..9] ]
  

pretty :: String -> String
pretty = ((tl++dsh++dn++dsh++dn++dsh++tr++"\n"++vt++" ")++)
         . (++(" "++vt++" \n"++bl++dsh++up++dsh++up++dsh++br))
         . intercalate (" "++vt++"\n"++vl++dsh++pl++dsh++pl++dsh++vr++" \n"++vt++" ")
         . map (intercalate (" "++vt++"\n"++vt++" ")) . byThree
         . map (intercalate (" "++vt++" ")). byThree
         . map (intersperse ' ')  . byThree
         . map (\d -> if d == '0' then '\x005F' else d)
  where
    byThree :: [a] -> [[a]]
    byThree (a : b : c : xs) = [a,b,c] : byThree xs
    byThree [] = []
    tl = "\x250F"
    tr = "\x2513" 
    bl = "\x2517"
    br = "\x251B" 
    dn = "\x2533"
    up = "\x253B"
    vl = "\x2523"
    vr = "\x252B"
    vt = "\x2503"
    pl = "\x254B"
    dsh = replicate 7 '\x2501'
  
printProblem :: Form (Int, Int, Int) -> IO ()
printProblem = putStrLn . pretty . showSquares . toLiterals

printSolution :: [Literal (Int, Int, Int)] -> IO ()
printSolution = putStrLn . pretty . showSquares

printAllSolutions :: Form (Int, Int, Int) -> Form (Int, Int, Int) -> IO ()
printAllSolutions problem constraints = mapM_ printSolution $ dpll (constraints <&&> problem)