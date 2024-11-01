module Utils.MeasureTime where

import System.CPUTime ( getCPUTime )
import Text.Printf ( printf )

measureTime :: IO a -> IO a
measureTime action = do
    start <- getCPUTime
    result <- action
    end <- getCPUTime
    let duration = (fromIntegral (end - start) / 1e12) :: Double
    printf "Computation time: %.3f sec\n" duration
    return result