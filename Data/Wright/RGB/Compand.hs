module Data.Wright.RGB.Compand (compand, uncompand) where

import Data.Wright.Types

compand :: Gamma -> ℝ -> ℝ
compand gamma v = case gamma of
  Gamma g -> v**(1/g)
  SRGB    -> if v <= 0.0031308 then 12.92*v else 1.055*v**(1/2.4)-0.055
  LStar   -> if v <= e         then v*k/100 else 1.6*v**(1/3)-0.16

uncompand :: Gamma -> ℝ -> ℝ
uncompand gamma v = case gamma of
  Gamma g -> v**g
  SRGB    -> if v <= 0.04045 then v/12.92 else ((v+0.055)/1.055)**2.4
  LStar   -> if v <= 0.08    then 100*v/k else ((v+0.16)/1.16)**3

e :: ℝ
e = 216/24389

k :: ℝ
k = 24389/27
