
module Module.Sudoku where

import Types.SudokuTypes (Form(..), Clause(Or), Literal(P, N), (<&&>))

sudoku :: Form (Int, Int, Int)
sudoku = allFilled <&&> noneFilledTwice
         <&&> rowsComplete <&&> columnsComplete <&&> squaresComplete
         <&&> rowsNoRepetition <&&> columnsNoRepetition <&&> squaresNoRepetition

allFilled :: Form (Int,Int,Int)
allFilled = And [ Or [ P (i,j,n) | n <- [1..9] ]
                | i <- [1..9], j <- [1..9] ]

noneFilledTwice :: Form (Int,Int,Int)
noneFilledTwice = And [ Or [ N (i, j, n), N (i, j, n') ]
                      | i <- [1..9], j <- [1..9],
                        n <- [1..9], n' <- [1..(n-1)]]

rowsComplete :: Form (Int,Int,Int)
rowsComplete = And [ Or [ P (i, j, n) | j <- [1..9] ]
                   | i <- [1..9], n <- [1..9] ]

columnsComplete :: Form (Int,Int,Int)
columnsComplete = And [ Or [ P (i, j, n) | i <- [1..9] ]
                      | j <- [1..9], n <- [1..9] ]

squaresComplete :: Form (Int, Int, Int)
squaresComplete = And 
    [ Or [ P (i, j, n) | i <- [a..a+2], j <- [b..b+2] ]
    | a <- [1,4,7], b <- [1,4,7], n <- [1..9] ]

rowsNoRepetition :: Form (Int,Int,Int)
rowsNoRepetition = And [ Or [ N (i, j, n), N (i, j', n) ]
                       | i <- [1..9], n <- [1..9],
                         j <- [1..9], j' <- [1..(j-1)] ]

columnsNoRepetition :: Form (Int,Int,Int)
columnsNoRepetition = And [ Or [ N (i, j, n), N (i', j, n) ]
                          | j <- [1..9], n <- [1..9],
                            i <- [1..9], i' <- [1..(i-1)] ]

squaresNoRepetition :: Form (Int, Int, Int)
squaresNoRepetition = And 
    [ Or [ N (i, j, n), N (i', j', n) ]
    | a <- [1,4,7]
    , b <- [1,4,7]
    , n <- [1..9]
    , (i, j) <- [(x, y) | x <- [a..a+2], y <- [b..b+2]]
    , (i', j') <- [(x, y) | x <- [a..a+2], y <- [b..b+2]]
    , (i, j) < (i', j') 
    ]