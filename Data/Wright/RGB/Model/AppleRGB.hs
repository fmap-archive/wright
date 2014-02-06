module Data.Wright.RGB.Model.AppleRGB (appleRGB) where

import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
import Data.Wright.CIE.Illuminant.D65 (d65)

appleRGB :: Model
appleRGB = d65
  { gamma = Gamma 1.8
  , red   = Primary 0.6250 0.3400 0.244634
  , green = Primary 0.2800 0.5950 0.672034
  , blue  = Primary 0.1550 0.0700 0.083332
  }