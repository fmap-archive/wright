module Data.Wright.RGB.Matrix (m, m') where

import Numeric.Matrix (inv, Matrix(..), col, transpose)
import qualified Numeric.Matrix as M (fromList, toList)
import Data.Maybe (fromJust)
import Control.Applicative ((<$>), pure)
import Control.Applicative.Extra ((<***>))
import Data.Wright.Types

m :: Environment -> Matrix ℝ
m ws = M.fromList $
  [ [sr*xr, sg*xg, sb*xb]
  , [sr*yr, sg*yg, sb*yb]
  , [sr*zr, sg*zg, sb*zb]
  ] where [sr, sg, sb] = sPoint ws
          [[xr, yr, zr],
           [xg, yg, zg],
           [xb, yb, zb]] = chromCoords ws

m' :: Environment -> Matrix ℝ
m' = fromJust . inv . m

sPoint :: Environment -> [ℝ]
sPoint ws = col 1 
          $ ( fromJust
            . inv
            . transpose
            . M.fromList
            . chromCoords
            $ ws
            )
          * whitePoint ws

chromCoords :: Environment -> [[ℝ]]
chromCoords ws = triMax ws 
             <$> [red, green, blue]

whitePoint :: Environment -> Matrix ℝ
whitePoint = M.fromList . map pure . xyzToList . white

xyzToList :: XYZ -> [ℝ]
xyzToList (XYZ xyz) = concat . M.toList $ xyz

-- Maximum CIE stimulus value for the space in some given dimension.
triMax :: Environment -> (Environment -> Primary) -> [ℝ]
triMax ws g = [x0/y0 , 1 , (1-x0-y0)/y0]
  where [x0, y0] = [x, y] <***> g ws
