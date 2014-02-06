module Data.Wright.RGB.Model.CIERGB (cIERGB) where

import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
import Data.Wright.CIE.Illuminant.E (e)

cIERGB :: Model
cIERGB = e
  { gamma = Gamma 2.2
  , red   = Primary 0.7350 0.2650 0.176204
  , green = Primary 0.2740 0.7170 0.812985
  , blue  = Primary 0.1670 0.0090 0.010811
  }