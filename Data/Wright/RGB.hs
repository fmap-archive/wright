module Data.Wright.RGB where

import Data.Wright (Colour(..))
import Data.Wright.RGB.Matrix (m)
import Data.Wright.Types
import qualified Numeric.Matrix as M (map)

uncompand :: Gamma -> ℝ -> ℝ
uncompand gamma v = case gamma of
  Gamma g -> v**g
  SRGB    -> if v <= 0.04045 then v/12.92 else ((v+0.055)/1.055)**2.4
  LStar   -> let k = (24389/27) in if v <= 0.08 then 100*v/k else ((v+0.16)/1.16)**3

instance Colour RGB where
  toXYZ env (RGB rgb) = XYZ $ m env * M.map (uncompand $ gamma env) rgb
  acc (RGB rgb) = rgb
  cure = RGB
