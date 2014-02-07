module Data.Wright.RGB.Matrix (m, m') where

import Data.Matrix
import Numeric.Matrix (inv, col, transpose)
import qualified Numeric.Matrix as M (Matrix(..), fromList, toList)
import Data.Maybe (fromJust)
import Control.Applicative ((<$>), pure)
import Control.Applicative.Extra ((<***>))
import Data.Wright.Types

m :: Model -> M.Matrix ℝ
m ws = M.fromList $
  [ [sr*xr, sg*xg, sb*xb]
  , [sr*yr, sg*yg, sb*yb]
  , [sr*zr, sg*zg, sb*zb]
  ] where [sr, sg, sb] = sPoint ws
          [[xr, yr, zr],
           [xg, yg, zg],
           [xb, yb, zb]] = chromCoords ws

m' :: Model -> M.Matrix ℝ
m' = fromJust . inv . m

sPoint :: Model -> [ℝ]
sPoint ws = col 1 
          $ ( fromJust
            . inv
            . transpose
            . M.fromList
            . chromCoords
            $ ws
            )
          * whitePoint ws

chromCoords :: Model -> [[ℝ]]
chromCoords ws = triMax ws `map` [red, green, blue]

whitePoint :: Model -> M.Matrix ℝ
whitePoint = toMatrix . white

-- Maximum CIE stimulus value for the space in some given dimension.
triMax :: Model -> (Model -> Primary) -> [ℝ]
triMax ws g = [x0/y0 , 1 , (1-x0-y0)/y0]
  where [x0, y0] = [x, y] <***> g ws
