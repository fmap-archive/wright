module Data.Wright.RGB.Environment.PALSECAMRGB (pALSECAMRGB) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.D65 (d65)

pALSECAMRGB :: Environment
pALSECAMRGB = d65
  { gamma = 2.2
  , red   = Primary 0.6400 0.3300 0.222021
  , green = Primary 0.2900 0.6000 0.706645
  , blue  = Primary 0.1500 0.0600 0.071334
  }