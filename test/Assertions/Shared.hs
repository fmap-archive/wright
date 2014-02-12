module Assertions.Shared (ofLength, fromList) where

import Data.Wright (Colour(..), ℝ)
import Data.Vector (Vector, fromVector, toVector)

ofLength :: Int -> [a] -> [[a]]
ofLength n as = if null a then [b] else b : ofLength n a
  where (b, a) = (take n as, drop n as)

fromList :: (Colour m, Vector m) => [ℝ] -> m ℝ
fromList = fromVector . toVector
