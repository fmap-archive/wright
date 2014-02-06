module Data.Wright.RGB.Model.NTSCRGB (nTSCRGB) where

import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
import Data.Wright.CIE.Illuminant.C (c)

nTSCRGB :: Model
nTSCRGB = c
  { gamma = Gamma 2.2
  , red   = Primary 0.6700 0.3300 0.298839
  , green = Primary 0.2100 0.7100 0.586811
  , blue  = Primary 0.1400 0.0800 0.114350
  }