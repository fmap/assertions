{-# LANGUAGE QuasiQuotes #-}

module Main (main) where

import Control.Applicative ((<$>))
import Data.String.Interpolate (i)
import System.Cmd (system)
import System.Exit (ExitCode(..))
import Test.Assert (runAssertions)
import Paths_assert (getDataFileName)

is0 :: ExitCode -> Bool
is0 = (== ExitSuccess)

is1 :: ExitCode -> Bool
is1 = (== ExitFailure 1)

quietly :: String -> IO ExitCode
quietly = system . (++"&>/dev/null")

main :: IO ()
main = getDataFileName "test/fixtures" >>= \fixtures -> do
  greenTest <- is0 <$> quietly [i|runhaskell #{fixtures}/Green.hs|]
  redTest   <- is1 <$> quietly [i|runhaskell #{fixtures}/Red.hs|]
  mixedTest <- is1 <$> quietly [i|runhaskell #{fixtures}/Mixed.hs|]
  runAssertions $
    [ ("When all tests in a suite pass, it should exit with 0.", greenTest)
    , ("When some but not all of the tests in a suite pass, it should exit with 1.", mixedTest)
    , ("When all of the tests in a suite fail, it should exit with 1.", redTest)
    ]
