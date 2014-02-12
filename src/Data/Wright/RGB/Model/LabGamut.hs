module Data.Wright.RGB.Model.LabGamut (labGamut) where

import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

labGamut :: Model
labGamut = d50
  { gamma = undefined
  , red   = Primary undefined undefined undefined
  , green = Primary undefined undefined undefined
  , blue  = Primary undefined undefined undefined
  }