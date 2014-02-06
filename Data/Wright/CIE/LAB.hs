module Data.Wright.CIE.LAB where

import Data.Wright
import Data.Wright.Types
import Data.Wright.CIE.XYZ
import Numeric.Matrix (col)
import qualified Numeric.Matrix as M (fromList)

instance Colour CIELAB where
  acc (CIELAB lab) = lab
  cure = CIELAB
  toXYZ (Model _ wt _ _ _) (CIELAB lab) = XYZ . M.fromList . map return $
    [ xw * if fx**3>k then fx**3 else (116*fx-16)/j
    , yw * if l > 8 then ((l+16)/116)**3 else l/j
    , zw * if fz**4 > k then fz**3 else (116*fz-16)/j
    ] where [l, a, b] = col 1 lab
            [xw,yw,zw] = col 1 . acc $ wt
            fy = (l+16)/116
            fx = 2e-3 * a + fy
            fz = fy - 5e-3 * b
            (k, j) = (216/24389, 24389/27)
