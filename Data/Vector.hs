{-# LANGUAGE FlexibleInstances, UndecidableInstances #-}

module Data.Vector (Vector(..), vmap) where

import Data.Matrix (Matrix(..))
import qualified Numeric.Matrix as M (fromList, col)

class Vector v where
  toVector   :: v a -> (a, a, a)
  fromVector :: (a, a, a) -> v a

instance Vector [] where
  toVector = toVector' . take 3
    where toVector' xs | length xs >= 3 = (xs!!0,xs!!1,xs!!2)
                       | otherwise = error "toVector []: length < 3"
  fromVector (a, b, c) = [a, b, c]

instance Vector v => Matrix v where
  toMatrix   = M.fromList . map return . fromVector . toVector
  fromMatrix = fromVector . toVector . M.col 1

--instance Vector v => Functor v where
--  fmap f = fromVector . fmap' f . toVector
--    where fmap' f (a, b, c) = (f a, f b, f c)

vmap :: Vector v => (a -> b) -> v a -> v b
vmap f = fromVector . vmap' f . toVector
  where vmap' f (a, b, c) = (f a, f b, f c)
