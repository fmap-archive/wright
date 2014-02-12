module Data.Wright.CIE.Illuminant.E (e) where

import Data.Wright.Types (Model)
import Data.Wright.CIE.Illuminant.Environment (environment)

e :: Model
e = environment (1/3, 1/3)