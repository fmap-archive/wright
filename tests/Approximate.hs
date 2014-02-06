module Approximate where

import Numeric.Matrix (Matrix, MatrixElement, toList)

class Approximate a where
  approx :: a -> a -> Bool
  (=~) :: a -> a -> Bool
  (=~) = approx

instance Approximate Double where
  d0 `approx` d1 = abs (d1-d0) < 1e-2

instance (Approximate a, MatrixElement a) => Approximate (Matrix a) where
  m0 `approx` m1 = and $ zipWith approx (z m0) (z m1)
    where z = concat . toList

--instance (Colour a) => (Approximate a) where
--  c0 `approx` c1 = acc c0 `approx` acc c1
