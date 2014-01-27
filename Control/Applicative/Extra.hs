module Control.Applicative.Extra ((<***>)) where

import Control.Applicative (pure, (<*>), Applicative(..))

(<***>) :: Applicative f => f (a -> b) -> a -> f b
fs <***> m = fs 
         <*> pure m
