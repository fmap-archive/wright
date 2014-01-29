module Data.Wright.RGB.Environment.CIERGB (cIERGB) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.E (e)

cIERGB :: Environment
cIERGB = e
  { gamma = 2.2
  , red   = Primary 0.7350 0.2650 0.176204
  , green = Primary 0.2740 0.7170 0.812985
  , blue  = Primary 0.1670 0.0090 0.010811
  }