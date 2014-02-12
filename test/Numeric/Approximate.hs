{-# LANGUAGE FlexibleInstances #-}

module Numeric.Approximate where

import Data.Wright
import Data.Vector
import Numeric.Matrix (Matrix, MatrixElement, toList)
import Data.Function (on)

class Approximate a where
  approx :: a -> a -> Bool
  (=~) :: a -> a -> Bool
  (=~) = approx

instance Approximate Double where
  d0 `approx` d1 = abs (d1-d0) < 0.11

instance (Vector a, Approximate b) => Approximate (a b) where
  v0 `approx` v1 = (toVector v0) ~~ (toVector v1)
    where (a0,b0,c0) ~~ (a1,b1,c1) = and $ zipWith (=~) [a0,b0,c0] [a1,b1,c1]
