module Data.Wright.RGB.Environment.BetaRGB (betaRGB) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

betaRGB :: Environment
betaRGB = d50
  { gamma = 2.2
  , red   = Primary 0.6888 0.3112 0.303273
  , green = Primary 0.1986 0.7551 0.663786
  , blue  = Primary 0.1265 0.0352 0.032941
  }