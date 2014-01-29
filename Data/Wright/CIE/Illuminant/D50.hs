module Data.Wright.CIE.Illuminant.D50 (d50) where

import Data.Wright.Types (Model)
import Data.Wright.CIE.Illuminant (environment)

d50 :: Model
d50 = environment (0.34567, 0.35850)