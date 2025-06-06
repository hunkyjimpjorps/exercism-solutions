module CollatzConjecture
  ( collatz
  ) where

import Prelude
import Data.Maybe (Maybe(..))

collatz :: Int -> Maybe Int
collatz n | n <= 0 = Nothing
collatz 1 = Just 0
collatz n | n `mod` 2 == 0 = ((+) 1) <$> collatz (n / 2)
collatz n = ((+) 1) <$> collatz (3 * n + 1)