module Data.Wright.RGB.Environment.DonRGB4 (donRGB4) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

donRGB4 :: Environment
donRGB4 = d50
  { gamma = 2.2
  , red   = Primary 0.6960 0.3000 0.278350
  , green = Primary 0.2150 0.7650 0.687970
  , blue  = Primary 0.1300 0.0350 0.033680
  }