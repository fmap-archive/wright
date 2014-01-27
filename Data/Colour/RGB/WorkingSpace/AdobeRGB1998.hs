module Data.Colour.RGB.WorkingSpace.AdobeRGB1998 where 

import Data.Colour.Types (Workspace(..), Primary(..))
import Data.Colour.White (d65)

adobeRGB1998 :: Workspace
adobeRGB1998 = Workspace
  { gamma = 2.2
  , white = d65
  , red   = Primary 0.64 0.33 0.297361
  , green = Primary 0.21 0.71 0.627355
  , blue  = Primary 0.15 0.06 0.075285
  }
