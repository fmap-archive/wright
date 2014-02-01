import qualified Numeric.Matrix as M (Matrix(..), fromList, toList)
import Data.Wright (Colour(..))
import Data.Wright.RGB.Model.SRGB (sRGB)
import Data.Wright.CIE.LAB ()
import Data.Wright.RGB ()
import Data.Wright.Types (CIELAB(..), RGB(..), XYZ(..), ℝ)
import Test.Assert (runAssertions)

isComma :: Char -> Bool
isComma = (==',')

fields :: String -> [String]
fields ln = r : if null rs then [] else fields . drop 1 $ rs
  where (r, rs) = break isComma ln
 
ofLength :: Int -> [a] -> [[a]]
ofLength n as = if null a then [b] else b : ofLength n a
  where (b, a) = (take n as, drop n as)

parseFixture :: String -> (RGB, XYZ, CIELAB)
parseFixture = parseFixture' . ofLength 3 . map read . fields
  where parseFixture' [r,x,l] = (rgb r, xyz x, lab l)

parseFixtures :: String -> [(RGB, XYZ, CIELAB)]
parseFixtures = map parseFixture . lines

checkConsistency :: (RGB, XYZ, CIELAB) -> Bool
checkConsistency (rgb, xyz, lab) = and
  [ rgb == toRGB sRGB xyz
  , rgb == toRGB sRGB lab
  ] 

fromList :: Colour a => (M.Matrix ℝ -> a) -> [ℝ] -> a
fromList = (. M.fromList . map return)

rgb :: [ℝ] -> RGB
rgb = fromList RGB 

lab :: [ℝ] -> CIELAB
lab = fromList CIELAB

xyz :: [ℝ] -> XYZ
xyz = fromList XYZ

assertions :: String -> [(String, Bool)]
assertions s0 = let fixtures = parseFixtures s0 in
  [("Translation functions are consistent with the reference table.", and . map checkConsistency $ fixtures)
  ] 

main :: IO ()
main = readFile "fixtures/table.csv"
   >>= runAssertions . assertions
