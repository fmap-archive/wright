module Data.Wright.RGB.Environment.SMPTECRGB (sMPTECRGB) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.D65 (d65)

sMPTECRGB :: Environment
sMPTECRGB = d65
  { gamma = 2.2
  , red   = Primary 0.6300 0.3400 0.212395
  , green = Primary 0.3100 0.5950 0.701049
  , blue  = Primary 0.1550 0.0700 0.086556
  }