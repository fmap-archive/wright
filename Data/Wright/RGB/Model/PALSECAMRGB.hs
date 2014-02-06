module Data.Wright.RGB.Model.PALSECAMRGB (pALSECAMRGB) where

import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
import Data.Wright.CIE.Illuminant.D65 (d65)

pALSECAMRGB :: Model
pALSECAMRGB = d65
  { gamma = Gamma 2.2
  , red   = Primary 0.6400 0.3300 0.222021
  , green = Primary 0.2900 0.6000 0.706645
  , blue  = Primary 0.1500 0.0600 0.071334
  }