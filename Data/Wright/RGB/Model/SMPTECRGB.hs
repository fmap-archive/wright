module Data.Wright.RGB.Model.SMPTECRGB (sMPTECRGB) where

import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
import Data.Wright.CIE.Illuminant.D65 (d65)

sMPTECRGB :: Model
sMPTECRGB = d65
  { gamma = Gamma 2.2
  , red   = Primary 0.6300 0.3400 0.212395
  , green = Primary 0.3100 0.5950 0.701049
  , blue  = Primary 0.1550 0.0700 0.086556
  }