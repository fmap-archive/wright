module Data.Wright.RGB.Model.ECIRGBv2 (eCIRGBv2) where

import Data.Wright.Types (Model(..), Primary(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

eCIRGBv2 :: Model
eCIRGBv2 = d50
  { gamma = undefined
  , red   = Primary 0.6700 0.3300 0.320250
  , green = Primary 0.2100 0.7100 0.602071
  , blue  = Primary 0.1400 0.0800 0.077679
  }