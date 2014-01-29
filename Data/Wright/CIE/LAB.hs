module Data.Wright.CIE.LAB where

import Data.Wright
import Data.Wright.Types
import Data.Wright.CIE.XYZ
import Numeric.Matrix(col)
import qualified Numeric.Matrix as M (fromList)
import Control.Applicative (pure)

instance Colour CIELAB where
  toXYZ (Environment _ wt _ _ _) (CIELAB lab) = XYZ . M.fromList . map pure $
    [ x' * f'(1/116 * (l+16) + a/500)
    , y' * f'(1/116 * (l+16))
    , z' * f'(1/116 * (l+16) - b/200)
    ]
    where [l,a,b] = col 1 lab
          [x',y',z'] = col 1 . acc $ wt
          f' t | t > 6/29  = t**3
               | otherwise = 3*(6/29)**2 * (t-4/29)
  acc (CIELAB lab) = lab
