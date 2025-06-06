module Accumulate
  ( accumulate
  ) where

import Data.List (List(Nil), (:))

accumulate :: forall a b. (a -> b) -> List a -> List b
accumulate _ Nil = Nil
accumulate f (h : t) = (f h) : (accumulate f t)
