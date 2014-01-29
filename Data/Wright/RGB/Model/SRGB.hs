module Data.Wright.RGB.Model.SRGB (sRGB) where

import Data.Wright.Types (Model(..), Primary(..))
import Data.Wright.CIE.Illuminant.D65 (d65)

sRGB :: Model
sRGB = d65
  { gamma = 2.2
  , red   = Primary 0.6400 0.3300 0.212656
  , green = Primary 0.3000 0.6000 0.715158
  , blue  = Primary 0.1500 0.0600 0.072186
  }