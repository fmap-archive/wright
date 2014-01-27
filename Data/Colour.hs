module Data.Colour where

import Numeric.Matrix(Matrix(..))
import Data.Colour.Types

class Colour a where
  toXYZ :: Context -> a -> XYZ
  toRGB :: Context -> a -> RGB
  --toRGB c = toRGB c . toXYZ c
  toCIELAB :: Context -> a -> CIELAB
  --toCIELAB c = toCIELAB c . toXYZ c
  acc :: a -> Matrix ℝ

--
