module Data.Colour.RGB where

import Data.Colour (Colour(..))
import Data.Colour.RGB.Matrix (m)
import Data.Colour.Types

instance Colour RGB where
  toXYZ (Space ws) (RGB rgb) = XYZ 
                             $ m ws
                             * rgb
  acc (RGB rgb) = rgb
