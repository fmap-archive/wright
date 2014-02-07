module Data.Wright.CIE.Yxy where

import Data.Wright.Types
import Data.Wright.Colour (Colour(..))
import Data.Vector (fromVector)

instance Colour Yxy where
  toXYZ _ (Yxy y' x y) = fromVector $
    ( x*y'/y
    , y'
    , (1-x-y)*y'/y
    )
