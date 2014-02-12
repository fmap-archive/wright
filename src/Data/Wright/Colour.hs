module Data.Wright.Colour where

import Data.Wright.Types
import qualified Numeric.Matrix as M (map)
import Data.Wright.RGB.Matrix (m')
import Data.Vector (fromVector)
import Data.Matrix (toMatrix, fromMatrix)
import Data.Wright.RGB.Compand (compand)

class Colour m where
  toXYZ :: Model -> m ℝ -> XYZ ℝ
  toLAB :: Model -> m ℝ -> LAB ℝ
  toLAB m = toLAB m . toXYZ m
  toRGB :: Model -> m ℝ -> RGB ℝ
  toRGB m = toRGB m . toXYZ m
  toYxy :: Model -> m ℝ -> Yxy ℝ
  toYxy m = toYxy m . toXYZ m

instance Colour XYZ where
  toXYZ _ = id
  toRGB model@(Model γ _ _ _ _) xyz = fromMatrix
                                    $ compand γ `M.map` (m' model * toMatrix xyz)
  toLAB (Model _ (XYZ xw yw zw) _ _ _) (XYZ x y z) = fromVector $
    ( 116 * yf - 16
    , 500 * (xf - yf)
    , 200 * (yf - zf)
    )
    where [xf, yf, zf] = map f [x/xw,y/yw,z/zw]
          f t | t > (6/29)**3 = t**(1/3)
              | otherwise     = (t/3)*((29/6)**2) + 4/29
  toYxy _ (XYZ x y z) = fromVector $
    ( y
    , x/d
    , y/d
    ) where d = x+y+z
