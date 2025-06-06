module Hamming
  ( distance
  ) where

import Prelude

import Data.Array (foldl, zip)
import Data.Maybe (Maybe(..))
import Data.String (length)
import Data.String.CodeUnits (toCharArray)
import Data.Tuple (Tuple(..))

distance :: String -> String -> Maybe Int
distance s1 s2
  | length s1 /= length s2 = Nothing
  | otherwise = Just $ foldl check 0 pairs
      where
      cs1 = toCharArray s1
      cs2 = toCharArray s2
      pairs = zip cs1 cs2
      check acc (Tuple x y) = if x == y then acc else acc + 1
