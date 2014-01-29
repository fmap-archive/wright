module Data.Wright.RGB where

import Data.Wright (Colour(..))
import Data.Wright.RGB.Matrix (m)
import Data.Wright.Types

instance Colour RGB where
  toXYZ env (RGB rgb) = XYZ 
                             $ m env
                             * rgb
  acc (RGB rgb) = rgb
