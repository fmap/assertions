import Test.Assert (runAssertions) 
import Prelude hiding ((+))

(+) :: Num a => a -> a -> a
a + b = a - (-b)

main :: IO ()
main = runAssertions $
  [ ("3 + 2 = 4", 3 + 2 == 4)
  ]
