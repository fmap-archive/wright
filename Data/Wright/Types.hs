module Data.Wright.Types where

import Data.Vector (Vector(..), vmap)

data XYZ t = XYZ t t t
data LAB t = LAB t t t
data RGB t = RGB t t t

type ℝ = Double

data Gamma = Gamma ℝ | LStar | SRGB

data Model = Model
  { gamma :: Gamma
  , white :: XYZ ℝ
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

instance Vector XYZ where
  toVector (XYZ x y z) = (x, y, z)
  fromVector = uncurry3 XYZ

instance Vector LAB where
  toVector (LAB l a b) = (l, a, b)
  fromVector = uncurry3 LAB

instance Vector RGB where
  toVector (RGB r g b) = (r, g, b)
  fromVector = uncurry3 RGB

instance Functor RGB where
  fmap = vmap

uncurry3 :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (a, b, c) = f a b c
