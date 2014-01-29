module Data.Colour.RGB where

import Data.Colour (Colour(..))
import Data.Colour.RGB.Matrix (m)
import Data.Colour.Types

instance Colour RGB where
  toXYZ env (RGB rgb) = XYZ 
                             $ m env
                             * rgb
  acc (RGB rgb) = rgb
