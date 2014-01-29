module Data.Wright.RGB.Environment.AdobeRGB1998 (adobeRGB1998) where 

import Data.Wright.Types (Environment(..), Primary(..))
import Data.Wright.CIE.Illuminant (d65)

adobeRGB1998 :: Environment
adobeRGB1998 = d65
  { gamma = 2.2
  , red   = Primary 0.64 0.33 0.297361
  , green = Primary 0.21 0.71 0.627355
  , blue  = Primary 0.15 0.06 0.075285
  }
