
# Sudoku solver
This is a Haskell-based application that solves Sudoku puzzles using the **DPLL (Davis-Putnam-Logemann-Loveland) algorithm**, a popular method for solving SAT (Boolean satisfiability) problems. The DPLL algorithm is adapted here to handle Sudoku, treating each puzzle as a logic problem.
## Algorithm

The basic backtracking algorithm runs by choosing a literal, assigning a truth value to it, simplifying the formula and then recursively checking if the simplified formula is satisfiable; if this is the case, the original formula is satisfiable; otherwise, the same recursive check is done assuming the opposite truth value

![DPLL](https://upload.wikimedia.org/wikipedia/commons/d/dc/Dpll11.png)

In practice, DPLL is often very efficient. But it’s very slow in some cases, taking time that is exponential in the size of its input, which is the same as checking satisfiability using truth tables. No algorithm for satisfiability is known that doesn’t share this property
## Example of Predefined Puzzle

A sample puzzle is predefined in the code:

```bash
sudokuProblem :: Form (Int, Int, Int)
sudokuProblem = And [ Or [P (1,8,8)], Or [P (1,9,2)], Or [P (2,1,6)]
                    , Or [P (2,4,4)], Or [P (4,1,4)], Or [P (4,5,7)]
                    , Or [P (4,6,2)], Or [P (5,1,5)], Or [P (5,7,4)]
                    , Or [P (5,8,3)], Or [P (6,5,1)], Or [P (7,4,8)]
                    , Or [P (7,7,6)], Or [P (8,2,8)], Or [P (8,3,1)]
                    , Or [P (9,2,2)], Or [P (9,9,7)]]
```
##     Requirements

* GHC (Glasgow Haskell Compiler): Ensure you have GHC installed. 
* Cabal: For managing Haskell dependencies and building the project.

## Run Locally

Clone the repository and navigate to the project directory:

```bash

git clone https://github.com/HJyup/sudoku-solver.git
cd sudoku-solver

```

Build the project with Cabal:

```bash

cabal build

```

Run the application with Cabal:

```bash

cabal run sudoku-solver

```

Start the server

```bash

npm run start

```


## License

[MIT](https://choosealicense.com/licenses/mit/)

