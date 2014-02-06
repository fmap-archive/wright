module Data.Wright.RGB.Model.AdobeRGB1998 (adobeRGB1998) where

import Data.Wright.Types (Model(..), Primary(..), Gamma(..))
import Data.Wright.CIE.Illuminant.D65 (d65)

adobeRGB1998 :: Model
adobeRGB1998 = d65
  { gamma = Gamma 2.2
  , red   = Primary 0.6400 0.3300 0.297361
  , green = Primary 0.2100 0.7100 0.627355
  , blue  = Primary 0.1500 0.0600 0.075285
  }