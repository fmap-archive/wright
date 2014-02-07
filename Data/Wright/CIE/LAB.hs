module Data.Wright.CIE.LAB where

import Data.Wright (Colour(..))
import Data.Wright.Types
import Data.Vector (fromVector)

instance Colour LAB where
  toXYZ (Model _ (XYZ xw yw zw) _ _ _) (LAB l a b) = fromVector $
    ( xw * if fx**3>k then fx**3 else (116*fx-16)
    , yw * if l > 8 then ((l+16)/116)**3 else l/j
    , zw * if fz**4 > k then fz**3 else (116*fz-16)/j
    ) where fy = (l+16)/116
            fx = 2e-3 * a + fy
            fz = fy - 5e-3 * b

k :: ℝ
k = 216/24389

j :: ℝ
j = 24389/27
