module Assertions.Transform (assertions) where

import Data.Wright (Colour(..), sRGB, LAB(..), RGB(..), XYZ(..), Yxy(..), ℝ)
import Test.Assert (runAssertions)
import Control.Lens (over, mapped, _2)
import Numeric.Approximate (Approximate(..))
import Data.CSV (parse)
import Assertions.Shared (ofLength, fromList)
import Paths_wright (getDataFileName)

type Fixture = (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ)

parseFixtures :: String -> [Fixture]
parseFixtures = map parseFixture . parse
 where parseFixture = parseFixture' . ofLength 3 . map read
       parseFixture' [r,x,l,y] = (fromList r, fromList x, fromList l, fromList y)

generateAssertions :: [Fixture] -> [(String, Bool)]
generateAssertions fs = over (mapped . _2) (`all` fs) $
  [ ("RGB --> XYZ", checkRGB2XYZ)
  , ("XYZ --> RGB", checkXYZ2RGB)
  , ("RGB --> LAB", checkRGB2LAB)
  , ("LAB --> RGB", checkLAB2RGB)
  , ("XYZ --> LAB", checkXYZ2LAB)
  , ("LAB --> XYZ", checkLAB2XYZ)
  , ("XYZ --> Yxy", checkXYZ2Yxy)
  , ("Yxy --> XYZ", checkYxy2XYZ)
  , ("Yxy --> RGB", checkYxy2RGB)
  , ("RGB --> Yxy", checkRGB2Yxy)
  , ("Yxy --> LAB", checkYxy2LAB)
  , ("LAB --> Yxy", checkLAB2Yxy)
  ]

assertions :: IO [(String, Bool)]
assertions = getDataFileName "test/fixtures/convert/conv.csv"
         >>= readFile
         >>= return . generateAssertions . parseFixtures

checkRGB2XYZ :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkRGB2XYZ (rgb, xyz, _, _) = xyz =~ toXYZ sRGB rgb

checkXYZ2RGB :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkXYZ2RGB (rgb, xyz, _, _) = rgb =~ toRGB sRGB xyz

checkRGB2LAB :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkRGB2LAB (rgb, _, lab, _) = lab =~ toLAB sRGB rgb

checkLAB2RGB :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkLAB2RGB (rgb, _, lab, _) = rgb =~ toRGB sRGB lab

checkXYZ2LAB :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkXYZ2LAB (_, xyz, lab, _) = lab =~ toLAB sRGB xyz

checkLAB2XYZ :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkLAB2XYZ (_, xyz, lab, _) = xyz =~ toXYZ sRGB lab

checkXYZ2Yxy :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkXYZ2Yxy (_, xyz, _, yxy) = yxy =~ toYxy sRGB xyz

checkYxy2XYZ :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkYxy2XYZ (_, xyz, _, yxy) = xyz =~ toXYZ sRGB yxy

checkYxy2RGB :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkYxy2RGB (rgb, _, _, yxy) = rgb =~ toRGB sRGB yxy

checkRGB2Yxy :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkRGB2Yxy (rgb, _, _, yxy) = yxy =~ toYxy sRGB rgb

checkYxy2LAB :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkYxy2LAB (_, _, lab, yxy) = lab =~ toLAB sRGB yxy

checkLAB2Yxy :: (RGB ℝ, XYZ ℝ, LAB ℝ, Yxy ℝ) -> Bool
checkLAB2Yxy (_, _, lab, yxy) = yxy =~ toYxy sRGB lab

