module Data.Wright.CIE.Illuminant.Environment (environment) where

import Data.Wright.Colour
import Data.Wright.CIE.Yxy ()
import Data.Wright.Types (Model(..), Yxy(..), ℝ)

environment :: (ℝ, ℝ) -> Model
environment (x,y) = Model { white = toXYZ def yxy }
  where yxy = Yxy 1 x y
        def = Model {} -- (Unused.)
