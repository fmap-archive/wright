module Data.Wright.RGB.Environment.WideGamutRGB (wideGamutRGB) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

wideGamutRGB :: Environment
wideGamutRGB = d50
  { gamma = 2.2
  , red   = Primary 0.7350 0.2650 0.258187
  , green = Primary 0.1150 0.8260 0.724938
  , blue  = Primary 0.1570 0.0180 0.016875
  }