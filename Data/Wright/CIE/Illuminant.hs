module Data.Wright.CIE.Illuminant (environment) where

import Data.Vector (fromVector)
import Data.Wright.Types (Model(..), XYZ(..), Chromacity, ℝ)

environment :: Chromacity -> Model
environment wt = Model { white = normalise wt }

-- Normalise (x,y) chromacity coordinates assuming unit luminance.
normalise :: Chromacity -> XYZ ℝ
normalise (xc,yc) = fromVector (x,y,z)
  where x = xc * y/yc 
        y = 1
        z = (1-xc-yc) * (y/yc)
