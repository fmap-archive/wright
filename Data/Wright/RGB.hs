module Data.Wright.RGB where

import Control.Applicative ((<$>))
import Data.Wright (Colour(..))
import Data.Wright.RGB.Matrix (m)
import Data.Wright.Types
import qualified Numeric.Matrix as M (map)
import Data.Matrix
import Data.Wright.RGB.Compand (uncompand)

instance Colour RGB where
  toXYZ model@(Model γ _ _ _ _) rgb = fromMatrix
                                    $ m model * toMatrix (uncompand γ <$> rgb)
