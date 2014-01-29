module Data.Wright.RGB.Environment.EktaSpacePS5 (ektaSpacePS5) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

ektaSpacePS5 :: Environment
ektaSpacePS5 = d50
  { gamma = 2.2
  , red   = Primary 0.6950 0.3050 0.260629
  , green = Primary 0.2600 0.7000 0.734946
  , blue  = Primary 0.1100 0.0050 0.004425
  }