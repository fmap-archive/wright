module Data.Wright.RGB.Environment.ColorMatchRGB (colorMatchRGB) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

colorMatchRGB :: Environment
colorMatchRGB = d50
  { gamma = 1.8
  , red   = Primary 0.6300 0.3400 0.274884
  , green = Primary 0.2950 0.6050 0.658132
  , blue  = Primary 0.1500 0.0750 0.066985
  }