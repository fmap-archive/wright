module Data.Wright.RGB.Environment.ProPhotoRGB (proPhotoRGB) where

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant.D50 (d50)

proPhotoRGB :: Environment
proPhotoRGB = d50
  { gamma = 1.8
  , red   = Primary 0.7347 0.2653 0.288040
  , green = Primary 0.1596 0.8404 0.711874
  , blue  = Primary 0.0366 0.0001 0.000086
  }