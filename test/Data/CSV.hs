module Data.CSV (parse) where

parse :: String -> [[String]]
parse = map fields . lines

isComma :: Char -> Bool
isComma = (==',')

fields :: String -> [String]
fields ln = r : if null rs then [] else fields . drop 1 $ rs
  where (r, rs) = break isComma ln
