module Assertions.Shared (ofLength, fromList, getBaseDirectory) where

import Data.Wright (Colour(..), ℝ)
import Control.Applicative ((<$>))
import System.Environment (getExecutablePath)
import System.FilePath (splitFileName)
import Data.Vector (Vector, fromVector, toVector)
 
getBaseDirectory :: IO FilePath
getBaseDirectory = fst . splitFileName <$> getExecutablePath

ofLength :: Int -> [a] -> [[a]]
ofLength n as = if null a then [b] else b : ofLength n a
  where (b, a) = (take n as, drop n as)

fromList :: (Colour m, Vector m) => [ℝ] -> m ℝ
fromList = fromVector . toVector
