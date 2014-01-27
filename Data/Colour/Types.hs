module Data.Colour.Types where

import Numeric.Matrix(Matrix(..))

type ℝ = Double

-- Each three-row vectors:
data XYZ    = XYZ    (Matrix ℝ) deriving (Show)
data RGB    = RGB    (Matrix ℝ) deriving (Show)
data CIELAB = CIELAB (Matrix ℝ) deriving (Show)

type White  = XYZ

data Workspace = Workspace
  { gamma :: ℝ
  , white :: White -- reference white
  , red   :: Primary
  , green :: Primary
  , blue  :: Primary
  }

data Primary = Primary 
  { x :: ℝ
  , y :: ℝ
  , z :: ℝ 
  }

data Context = Reference White 
             | Space Workspace
