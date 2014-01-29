module Data.Wright where

import Data.Wright.Types
import Data.Maybe (fromJust)
import Numeric.Matrix (Matrix(..),col,inv)
import Control.Applicative (pure)
import qualified Numeric.Matrix as M (fromList)
import Data.Wright.RGB.Matrix (m')

class Colour a where
  toXYZ :: Model -> a -> XYZ
  toRGB :: Model -> a -> RGB
  toRGB e = toRGB e . toXYZ e
  toCIELAB :: Model -> a -> CIELAB
  toCIELAB e = toCIELAB e . toXYZ e
  acc :: a -> Matrix ℝ

instance Colour XYZ where
  toXYZ _ xyz = xyz
  toRGB env (XYZ xyz) = RGB 
                  $ m' env
                  * xyz
  toCIELAB (Model _ wt _ _ _) (XYZ xyz) = CIELAB . M.fromList . map pure $
    [ 116 * f(y/y') - 16
    , 500 * (f(x/x') - f(y/y'))
    , 200 * (f(y/y') - f(z/z'))
    ]
    where [x,y,z]    = col 1 xyz 
          [x',y',z'] = col 1 . acc $ wt
          f t | t > (6/29)**3 = t**(1/3)
              | otherwise     = (t/3)*((29/6)**2) + 4/29
  acc (XYZ xyz) = xyz
