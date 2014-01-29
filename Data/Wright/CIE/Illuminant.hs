module Data.Wright.CIE.Illuminant (d65) where

import qualified Numeric.Matrix as M (Matrix, fromList)
import Data.Wright.Types (Environment(..), XYZ(..), ℝ)

environment :: M.Matrix ℝ -> Environment
environment wt = Environment { white = XYZ wt }

d65 :: Environment
d65 = environment . M.fromList . map return $
  [ 0.95047
  , 1
  , 1.08883
  ]
