module Data.Wright.Types where

import Numeric.Matrix(Matrix(..))

type ℝ = Double

-- Each three-row vectors:
data XYZ    = XYZ    (Matrix ℝ) deriving (Show, Eq)
data RGB    = RGB    (Matrix ℝ) deriving (Show, Eq)
data CIELAB = CIELAB (Matrix ℝ) deriving (Show, Eq)

type White  = XYZ

data Gamma = Gamma ℝ | LStar | SRGB

data Model = Model
  { gamma :: Gamma
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

type Chromacity = (ℝ, ℝ)
