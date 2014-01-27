module Data.Colour.RGB where

import Numeric.Matrix (inv, Matrix(..), col)
import qualified Numeric.Matrix as M (fromList, toList)
import Control.Applicative ((<$>), pure)
import Control.Applicative.Extra ((<***>))
import Data.Maybe (fromJust)
import Data.Colour (Colour(..))
import Data.Colour.Types

instance Colour RGB where
  toXYZ (Space ws) (RGB rgb) = XYZ 
                             $ m ws
                             * rgb
  acc (RGB rgb) = rgb

m :: Workspace -> Matrix ℝ
m ws = M.fromList $
  [ [sr*xr, sg*xg, sb*xb]
  , [sr*yr, sg*yg, sb*yb]
  , [sr*zr, sg*zg, sb*zb]
  ] where [(xr, yr, zr),
           (xg, yg, zg),
           (xb, yb, zb)] = triMax ws 
                       <$> [ red
                           , green
                           , blue
                           ] 
          [sr, sg, sb] = col 1 
                       $ ( fromJust
                         . inv 
                         $ M.fromList 
                            [ [xr, xg, xb]
                            , [yr, yg, yb]
                            , [zr, zg, zb]
                            ]
                         )
                       * ( M.fromList 
                         . map pure 
                         $ [ xw
                           , yw
                           , zw
                           ]
                         )
          [xw, yw, zw] = (\(XYZ m)-> concat . M.toList $ m)
                       . white 
                       $ ws


-- Maximum CIE stimulus value for the space in some given dimension.
triMax :: Workspace -> (Workspace -> Primary) -> (ℝ,ℝ,ℝ)
triMax ws g = ( x0/y0
              , 1
              , (1-x0-y0)/y0
              )
  where [x0, y0] = [x, y] <***> g ws

