module Data.Colour.CIE.Illuminant (d65) where

import qualified Numeric.Matrix as M (fromList)
import Control.Applicative (pure)
import Data.Colour.Types (XYZ(..), White)

d65 :: White
d65 = XYZ . M.fromList . map pure $
  [ 0.95047
  , 1
  , 1.08883
  ]
