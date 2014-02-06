module Data.Wright.RGB.Model.BetaRGB (betaRGB) where

import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

betaRGB :: Model
betaRGB = d50
  { gamma = Gamma 2.2
  , red   = Primary 0.6888 0.3112 0.303273
  , green = Primary 0.1986 0.7551 0.663786
  , blue  = Primary 0.1265 0.0352 0.032941
  }