{-# LANGUAGE FlexibleInstances, UndecidableInstances #-}

module TODO where

import qualified Numeric.Matrix as M (Matrix, MatrixElement, fromList, col)

data XYZ t = XYZ t t t
data LAB t = LAB t t t

data Model = Model
  { gamma :: Double
  , white :: XYZ Double
  , red   :: XYZ Double
  , green :: XYZ Double
  , blue  :: XYZ Double
  }

class Matrix m where
  toMatrix   :: M.MatrixElement a => m a -> M.Matrix a
  fromMatrix :: M.MatrixElement a => M.Matrix a -> m a

class Vector v where
  toVector   :: v a -> (a, a, a)
  fromVector :: (a, a, a) -> v a

instance Vector v => Functor v where
  fmap f = fromVector . fmap' f . toVector
    where fmap' f (a, b, c) = (f a, f b, f c)

instance Vector [] where
  toVector = toVector' . take 3
    where toVector' xs | length xs >= 3 = (xs!!0,xs!!1,xs!!2)
                       | otherwise = error "toVector []: length < 3"
  fromVector (a, b, c) = [a, b, c]

instance Vector v => Matrix v where
  toMatrix   = M.fromList . map return . fromVector . toVector
  fromMatrix = fromVector . toVector . M.col 1

uncurry3 :: (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (a, b, c) = f a b c

instance Vector XYZ where
  toVector (XYZ x y z) = (x, y, z)
  fromVector = uncurry3 XYZ

instance Vector LAB where
  toVector (LAB l a b) = (l, a, b)
  fromVector = uncurry3 LAB

class Colour m where
  toXYZ :: Model -> m Double -> XYZ Double
  toLAB :: Model -> m Double -> LAB Double

instance Colour XYZ where
  toXYZ _ = id
  toLAB (Model _ (XYZ xw yw zw) _ _ _) (XYZ x y z) = fromVector $
    ( 116 * yf - 16
    , 500 * (xf - yf)
    , 200 * (yf - zf)
    )
    where [xf, yf, zf] = map f [x/xw,y/yw,z/zw]
          f t | t > (6/29)**3 = t**(1/3)
              | otherwise     = (t/3)*((29/6)**2) + 4/29
