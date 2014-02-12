module Data.Matrix where

import qualified Numeric.Matrix as M (Matrix, MatrixElement)

class Matrix m where
  toMatrix   :: M.MatrixElement a => m a -> M.Matrix a
  fromMatrix :: M.MatrixElement a => M.Matrix a -> m a
