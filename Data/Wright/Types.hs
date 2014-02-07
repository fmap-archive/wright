module Data.Wright.Types where

import Data.Vector (Vector(..), vmap)

data XYZ t = XYZ t t t deriving (Show)
data LAB t = LAB t t t deriving (Show)
data RGB t = RGB t t t deriving (Show)
data Yxy t = Yxy t t t deriving (Show) -- "xyY"

type ℝ = Double

data Gamma = Gamma ℝ | LStar | SRGB

data Application = Graphics | Textiles --CIE94

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

instance Vector XYZ where
  toVector (XYZ x y z) = (x, y, z)
  fromVector = uncurry3 XYZ

instance Functor XYZ where
  fmap = vmap

instance Vector LAB where
  toVector (LAB l a b) = (l, a, b)
  fromVector = uncurry3 LAB

instance Functor LAB where
  fmap = vmap

instance Vector RGB where
  toVector (RGB r g b) = (r, g, b)
  fromVector = uncurry3 RGB

instance Functor RGB where
  fmap = vmap

instance Vector Yxy where
  toVector (Yxy y' x y) = (y', x, y)
  fromVector = uncurry3 Yxy

instance Functor Yxy where
  fmap = vmap

uncurry3 :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (a, b, c) = f a b c
