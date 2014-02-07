module Data.Wright.CIE.Illuminant.D75 (d75) where

import Data.Wright.Types (Model)
import Data.Wright.CIE.Illuminant.Environment (environment)

d75 :: Model
d75 = environment (0.29902, 0.31485)