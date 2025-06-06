module Hamming
  ( distance
  ) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.String (drop, length, take)

distance :: String -> String -> Maybe Int
distance s1 s2 | length s1 /= length s2 = Nothing
distance "" "" = Just 0
distance s1 s2
  | take 1 s1 == take 1 s2 = distance (drop 1 s1) (drop 1 s2)
  | otherwise = (_ + 1) <$> distance (drop 1 s1) (drop 1 s2)