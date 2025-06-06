module CollatzConjecture
  ( collatz
  ) where

import Prelude

import Data.Int (even)
import Data.Maybe (Maybe(..))

collatz :: Int -> Maybe Int
collatz n | n <= 0 = Nothing
collatz n = Just $ doCollatz 0 n
  where
  doCollatz acc x
    | x == 1 = acc
    | even x = doCollatz (acc + 1) (x / 2)
    | otherwise = doCollatz (acc + 1) (3 * x + 1)
