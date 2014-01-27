module Data.Colour.CIE.XYZ where 

import Data.Colour
import Data.Colour.Types
import Data.Maybe (fromJust)
import Numeric.Matrix (Matrix(..),col,inv)
import Control.Applicative (pure)
import qualified Numeric.Matrix as M (fromList)
import qualified Data.Colour.RGB as RGB (m)

instance Colour XYZ where
  toXYZ _ xyz = xyz
  toRGB (Space ws) (XYZ xyz) = RGB 
                  $ m ws
                  * xyz
  toCIELAB (Reference wt) (XYZ xyz) = CIELAB . M.fromList . pure $
    [ 116 * f(y/y') - 16
    , 500 * (f(x/x') - f(y/y'))
    , 200 * (f(y/y') - f(z/z'))
    ]
    where [x,y,z]    = col 1 xyz 
          [x',y',z'] = col 1 . acc $ wt
          f t | t > (6/29)**3 = t**(1/3)
              | otherwise     = (t/3)*((29/6)**2) + 4/29
  acc (XYZ xyz) = xyz

m :: Workspace -> Matrix ℝ
m = fromJust . inv . RGB.m
