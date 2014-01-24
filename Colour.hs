module Colour where

import Numeric.Matrix (Matrix(..), col, inv)
import qualified Numeric.Matrix as M (toList, fromList)
import Control.Applicative ((<*>),(<$>), Applicative(..))
import Data.Maybe (fromJust)

type ℝ = Double

-- Each three-row vectors:
data XYZ = XYZ (Matrix ℝ) deriving (Show)
data RGB = RGB (Matrix ℝ) deriving (Show)

data WS = WS
  { gamma :: ℝ
  , white :: XYZ -- reference white
  , red   :: Primary
  , green :: Primary
  , blue  :: Primary
  }

data Primary = Primary 
  { x :: ℝ
  , y :: ℝ
  , z :: ℝ 
  }

d65 :: XYZ
d65 = XYZ . M.fromList . map pure $
  [ 0.95047
  , 1
  , 1.08883
  ]

adobeRGB1998 :: WS
adobeRGB1998 = WS
  { gamma = 2.2
  , white = d65
  , red   = Primary 0.64 0.33 0.297361
  , green = Primary 0.21 0.71 0.627355
  , blue  = Primary 0.15 0.06 0.075285
  }

rgbM :: WS -> Matrix ℝ
rgbM ws = M.fromList $
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

rgbM' :: WS -> Matrix ℝ
rgbM' = fromJust
      . inv 
      . rgbM

(<***>) :: Applicative f => f (a -> b) -> a -> f b
fs <***> m = fs 
         <*> pure m

-- Maximum CIE stimulus value for the space in some given dimension.
triMax :: WS -> (WS -> Primary) -> (ℝ,ℝ,ℝ)
triMax ws g = ( x0/y0
              , 1
              , (1-x0-y0)/y0
              )
  where [x0, y0] = [x, y] <***> g ws

class Colour a where
  toXYZ :: a -> XYZ
  toRGB :: a -> RGB
  toRGB = toRGB . toXYZ

instance Colour XYZ where
  toXYZ = id
  toRGB (XYZ xyz) = RGB 
                  $ rgbM' adobeRGB1998
                  * xyz

instance Colour RGB where
  toRGB = id
  toXYZ (RGB rgb) = XYZ 
                  $ rgbM adobeRGB1998
                  * rgb
