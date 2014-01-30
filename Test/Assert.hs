module Test.Assert (runAssertions) where

import System.Console.ANSI (setSGR, SGR(..), ConsoleLayer(..), ColorIntensity(..), Color(..))
import System.Exit (exitSuccess, exitFailure)

type Assertion = (String, Bool)

assert :: Assertion -> IO ()
assert (str, prop) = setSGR [SetColor Foreground Dull col]
                  >> putStrLn str 
                  >> setSGR []
  where col = if prop then Green else Red

runAssertions :: [Assertion] -> IO ()
runAssertions as = sequence (map assert as)
                >> if (and . map snd $ as) then exitSuccess else exitFailure

main :: IO ()
main = runAssertions $
  [ ("A passing test!", True || False)
  , ("A failing test!", True && False)
  ]
