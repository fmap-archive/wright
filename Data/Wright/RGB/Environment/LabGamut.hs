module Data.Wright.RGB.Environment.LabGamut (labGamut) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

labGamut :: Environment
labGamut = d50
  { gamma = undefined
  , red   = Primary undefined undefined undefined
  , green = Primary undefined undefined undefined
  , blue  = Primary undefined undefined undefined
  }