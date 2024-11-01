module Types.SudokuTypes (Form(..), Clause(Or), Literal(P, N), neg, (<&&>)) where

data Literal atom = P atom | N atom
                    deriving (Eq, Show)

newtype Clause atom = Or [Literal atom]
                   deriving (Eq, Show)

newtype Form atom = And [Clause atom]
                   deriving (Eq, Show)

neg :: Literal atom -> Literal atom
neg (P a) = N a
neg (N a) = P a                          

(<&&>) :: Form a -> Form a -> Form a
And xs <&&> And ys = And ( xs ++ ys )