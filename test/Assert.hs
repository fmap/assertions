import Test.Assert (runAssertions)
import System.Cmd (system)
import System.Exit (ExitCode(..))
import Control.Applicative ((<$>))

is0 :: ExitCode -> Bool
is0 = (== ExitSuccess)

is1 :: ExitCode -> Bool
is1 = (== ExitFailure 1)

quietly :: String -> IO ExitCode
quietly = system . (++"&>/dev/null")

main :: IO ()
main = do
  greenTest <- is0 <$> quietly "runhaskell test/fixtures/Green.hs"
  redTest   <- is1 <$> quietly "runhaskell test/fixtures/Red.hs"
  mixedTest <- is1 <$> quietly "runhaskell test/fixtures/Mixed.hs"
  runAssertions $
    [ ("When all tests in a suite pass, it should exit with 0.", greenTest)
    , ("When some but not all of the tests in a suite pass, it should exit with 1.", mixedTest)
    , ("When all of the tests in a suite fail, it should exit with 1.", redTest)
    ]
