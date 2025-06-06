module Triangle
  ( Triangle(Equilateral, Isosceles, Scalene)
  , triangleKind
  ) where

import Prelude
import Data.Either (Either(Left, Right))

data Triangle
  = Equilateral
  | Isosceles
  | Scalene

derive instance eqTriangle :: Eq Triangle

instance showTriangle :: Show Triangle where
  show Equilateral = "Equilateral"
  show Isosceles = "Isosceles"
  show Scalene = "Scalene"

triangleKind :: Int -> Int -> Int -> Either String Triangle
triangleKind a b c
  | a <= 0 || b <= 0 || c <= 0 = Left "Invalid lengths"
  | a + b <= c || a + c <= b || b + c <= a = Left "Violates inequality"
  | a == b && b == c = Right Equilateral
  | a == b || b == c || a == c = Right Isosceles
  | otherwise = Right Scalene