module Main where

import Control.Parallel
import Control.Parallel.Strategies
import System.IO
import Data.List.Split
import Control.DeepSeq

process :: [String] -> [String]
process lines = do
    let xs = map (\x -> read x :: Double) lines
        ys = map (\x -> 1.0 / (1.0 + (exp (-x)))) xs
        retlines = map (\x -> (show x ) ++ "\n") ys
    retlines

main :: IO ()
main = do
    hSetBuffering stdout (BlockBuffering (Just 2048))
    c <- getContents
    let xs = lines c
        ys = (process xs) `using` parListChunk 11 rdeepseq
    putStr (foldr (++) [] ys)
