module Control.Applicative.Extra ((<***>), (.:)) where

import Control.Applicative (pure, (<*>), Applicative(..))

(<***>) :: Applicative f => f (a -> b) -> a -> f b
fs <***> m = fs 
         <*> pure m

(.:) :: (Functor f, Functor g) => (a -> b) -> f (g a) -> f (g b) -- If <$> belongs..
(.:) = fmap fmap fmap

infixr 8 .:
