module Assertions.Metric (assertions) where

import Data.Wright (LAB, Model(..), Application(..), ℝ, cie76, cie94, cie2000)
import Numeric.Approximate (Approximate(..))
import Control.Lens (over, mapped, _2)
import Test.Assert (runAssertions)
import Data.CSV (parse)
import Assertions.Shared (fromList)
import Paths_wright (getDataFileName)

type DE1976  = ℝ
type DE1994T = ℝ
type DE1994G = ℝ
type DE2000  = ℝ
type Fixture = (LAB ℝ, LAB ℝ, DE1976, DE1994T, DE1994G, DE2000)

parseFixture :: [String] -> Fixture
parseFixture = record . map read
  where record xs = ( fromList . take 3 $ xs
                    , fromList . take 3 . drop 3 $ xs
                    , xs!!6 , xs!!7 , xs!!8 , xs!!9)

parseFixtures :: String -> [Fixture]
parseFixtures = map parseFixture . parse

generateAssertions :: [Fixture] -> [(String, Bool)]
generateAssertions fs = over (mapped . _2) (`all` fs) $
  [ ("ΔE, CIE76"            , checkCIE76)
  , ("ΔE, CIE94 (Graphics)" , checkCIE94G)
  , ("ΔE, CIE94 (Textiles)" , checkCIE94T)
  , ("ΔE, CIE2000"          , checkCIE2k)
  ]

assertions :: IO [(String, Bool)]
assertions = getDataFileName "test/fixtures/diff/diff.csv"
         >>= readFile 
         >>= return . generateAssertions . parseFixtures

model :: Model
model = Model {}

checkCIE76 :: Fixture -> Bool
checkCIE76 (l0, l1, d, _, _, _) = l0 <~> l1 =~ d
  where (<~>) = cie76 model

checkCIE94T :: Fixture -> Bool
checkCIE94T (l0, l1, _, d, _, _) = l0 <~> l1 =~ d
  where (<~>) = cie94 model Textiles

checkCIE94G :: Fixture -> Bool
checkCIE94G (l0, l1, _, _, d, _) = l0 <~> l1 =~ d
  where (<~>) = cie94 model Graphics

checkCIE2k :: Fixture -> Bool
checkCIE2k (l0, l1, _, _, _, d) = l0 <~> l1 =~ d
  where (<~>) = cie2000 model 
