module Data.Wright.CIE.Illuminant (d65) where

import qualified Numeric.Matrix as M (Matrix, fromList)
import Data.Wright.Types (Environment(..), XYZ(..), Chromacity, ℝ)

d65 :: Environment
d65 = environment (0.31271, 0.32902)

environment :: Chromacity -> Environment
environment wt = Environment { white = normalise wt }

-- Normalise (x,y) chromacity coordinates assuming unit luminance.
normalise :: Chromacity -> XYZ
normalise (xc,yc) = XYZ . M.fromList . map return $ [x,y,z]
  where x = xc * y/yc 
        y = 1
        z = (1-xc-yc) * (y/yc)
