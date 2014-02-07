import qualified Numeric.Matrix as M (Matrix(..), fromList)
import Data.Wright (Colour(..))
import Data.Wright.RGB.Model.SRGB (sRGB)
import Data.Wright.CIE.LAB ()
import Data.Wright.RGB ()
import Data.Wright.Types (LAB(..), RGB(..), XYZ(..), ℝ)
import Test.Assert (runAssertions)
import Control.Applicative ((<$>))
import System.FilePath (splitFileName)
import System.Environment (getExecutablePath)
import Control.Lens (over, mapped, _2)
import Approximate (Approximate(..))
import CSV (parse)
import Data.Matrix
import Data.Vector
 
ofLength :: Int -> [a] -> [[a]]
ofLength n as = if null a then [b] else b : ofLength n a
  where (b, a) = (take n as, drop n as)

fromList :: (Colour m, Vector m) => [ℝ] -> m ℝ
fromList = fromVector . toVector

parseFixtures :: String -> [(RGB ℝ, XYZ ℝ, LAB ℝ)]
parseFixtures = map parseFixture . parse
 where parseFixture = parseFixture' . ofLength 3 . map read
       parseFixture' [r,x,l] = (fromList r, fromList x, fromList l)

checkRGB2XYZ :: (RGB ℝ, XYZ ℝ, LAB ℝ) -> Bool
checkRGB2XYZ (rgb, xyz, _) = xyz =~ toXYZ sRGB rgb

checkXYZ2RGB :: (RGB ℝ, XYZ ℝ, LAB ℝ) -> Bool
checkXYZ2RGB (rgb, xyz, _) = rgb =~ toRGB sRGB xyz

checkRGB2LAB :: (RGB ℝ, XYZ ℝ, LAB ℝ) -> Bool
checkRGB2LAB (rgb, _, lab) = lab =~ toLAB sRGB rgb

checkLAB2RGB :: (RGB ℝ, XYZ ℝ, LAB ℝ) -> Bool
checkLAB2RGB (rgb, _, lab) = rgb =~ toRGB sRGB lab

checkXYZ2LAB :: (RGB ℝ, XYZ ℝ, LAB ℝ) -> Bool
checkXYZ2LAB (_, xyz, lab) = lab =~ toLAB sRGB xyz

checkLAB2XYZ :: (RGB ℝ, XYZ ℝ, LAB ℝ) -> Bool
checkLAB2XYZ (_, xyz, lab) = xyz =~ toXYZ sRGB lab

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
