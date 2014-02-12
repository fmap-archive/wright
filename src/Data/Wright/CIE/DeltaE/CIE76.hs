module Data.Wright.CIE.DeltaE.CIE76 (cie76) where

import Data.Wright.Types
import Data.Wright.Colour (Colour(..))
import Data.Vector (Vector, fromVector, toVector)
import Control.Applicative.Extra ((.:))
import Data.Function (on)

cie76 :: Colour a => Model -> a ℝ -> a ℝ -> ℝ
cie76 model = euclid `on` toLAB model

euclid :: Vector a => a ℝ -> a ℝ -> ℝ
euclid = euclid' `on` toList

euclid' :: [ℝ] -> [ℝ] -> ℝ
euclid' = sqrt . sum . map (**2) .: zipWith (-) 

toList :: Vector a => a b -> [b]
toList = fromVector . toVector
