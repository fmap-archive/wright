module Data.Wright.RGB.Model.BruceRGB (bruceRGB) where

import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
import Data.Wright.CIE.Illuminant.D65 (d65)

bruceRGB :: Model
bruceRGB = d65
  { gamma = Gamma 2.2
  , red   = Primary 0.6400 0.3300 0.240995
  , green = Primary 0.2800 0.6500 0.683554
  , blue  = Primary 0.1500 0.0600 0.075452
  }