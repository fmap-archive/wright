module Data.Wright.RGB.Model.BestRGB (bestRGB) where

import Data.Wright.Types (Model(..), Primary(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

bestRGB :: Model
bestRGB = d50
  { gamma = 2.2
  , red   = Primary 0.7347 0.2653 0.228457
  , green = Primary 0.2150 0.7750 0.737352
  , blue  = Primary 0.1300 0.0350 0.034191
  }