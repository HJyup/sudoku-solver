module Main where

import Utils.MeasureTime
import Module.PrintSudoku (printAllSolutions)
import Module.Sudoku (sudoku)
import Types.SudokuTypes (Form(And), Clause(Or), Literal(P), (<&&>))


sudokuProblem :: Form (Int, Int, Int)
sudokuProblem = And [ Or [P (1,8,8)], Or [P (1,9,2)], Or [P (2,1,6)]
                    , Or [P (2,4,4)], Or [P (4,1,4)], Or [P (4,5,7)]
                    , Or [P (4,6,2)], Or [P (5,1,5)], Or [P (5,7,4)]
                    , Or [P (5,8,3)], Or [P (6,5,1)], Or [P (7,4,8)]
                    , Or [P (7,7,6)], Or [P (8,2,8)], Or [P (8,3,1)]
                    , Or [P (9,2,2)], Or [P (9,9,7)]]

main :: IO ()
main = do
  putStrLn "Solving the Sudoku problem:"
  measureTime $ printAllSolutions sudokuProblem sudoku
