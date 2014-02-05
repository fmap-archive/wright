import qualified Numeric.Matrix as M (Matrix(..), fromList)
import Data.Wright (Colour(..))
import Data.Wright.RGB.Model.SRGB (sRGB)
import Data.Wright.CIE.LAB ()
import Data.Wright.RGB ()
import Data.Wright.Types (CIELAB(..), RGB(..), XYZ(..), ℝ)
import Test.Assert (runAssertions)
import Control.Applicative ((<$>))
import System.FilePath (splitFileName)
import System.Environment (getExecutablePath)
import Control.Lens (over, mapped, _2)
import Approximate (Approximate(..))
import CSV (parse)
 
ofLength :: Int -> [a] -> [[a]]
ofLength n as = if null a then [b] else b : ofLength n a
  where (b, a) = (take n as, drop n as)

fromList :: Colour a => (M.Matrix ℝ -> a) -> [ℝ] -> a
fromList = (. M.fromList . map return)

rgb :: [ℝ] -> RGB
rgb = fromList RGB

xyz :: [ℝ] -> XYZ
xyz = fromList XYZ

lab :: [ℝ] -> CIELAB
lab = fromList CIELAB

parseFixtures :: String -> [(RGB, XYZ, CIELAB)]
parseFixtures = map parseFixture . parse
 where parseFixture = parseFixture' . ofLength 3 . map read
       parseFixture' [r,x,l] = (rgb r, xyz x, lab l)

(=~~) :: Colour a => a -> a -> Bool
c0 =~~ c1 = acc c0 =~ acc c1

checkRGB2XYZ :: (RGB, XYZ, CIELAB) -> Bool
checkRGB2XYZ (rgb, xyz, _) = xyz =~~ toXYZ sRGB rgb

checkXYZ2RGB :: (RGB, XYZ, CIELAB) -> Bool
checkXYZ2RGB (rgb, xyz, _) = rgb =~~ toRGB sRGB xyz

checkRGB2LAB :: (RGB, XYZ, CIELAB) -> Bool
checkRGB2LAB (rgb, _, lab) = lab =~~ toCIELAB sRGB rgb

checkLAB2RGB :: (RGB, XYZ, CIELAB) -> Bool
checkLAB2RGB (rgb, _, lab) = rgb =~~ toRGB sRGB lab

checkXYZ2LAB :: (RGB, XYZ, CIELAB) -> Bool
checkXYZ2LAB (_, xyz, lab) = lab =~~ toCIELAB sRGB xyz

checkLAB2XYZ :: (RGB, XYZ, CIELAB) -> Bool
checkLAB2XYZ (_, xyz, lab) = xyz =~~ toXYZ sRGB lab

assertions :: String -> [(String, Bool)]
assertions s0 = over (mapped . _2) (`all` parseFixtures s0) $
  [ ("RGB --> XYZ", checkRGB2XYZ)
  , ("XYZ --> RGB", checkXYZ2RGB)
  , ("RGB --> LAB", checkRGB2LAB)
  , ("LAB --> RGB", checkLAB2RGB)
  , ("XYZ --> LAB", checkXYZ2LAB)
  , ("LAB --> XYZ", checkLAB2XYZ)
  ]

main :: IO ()
main = fst . splitFileName <$> getExecutablePath
   >>= readFile . (++"fixtures/table.csv")
   >>= runAssertions . assertions
