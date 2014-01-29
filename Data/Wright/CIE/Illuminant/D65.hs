module Data.Wright.CIE.Illuminant.D65 (d65) where

import Data.Wright.Types (Model)
import Data.Wright.CIE.Illuminant (environment)

d65 :: Model
d65 = environment (0.31271, 0.32902)