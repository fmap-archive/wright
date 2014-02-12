import Test.Assert (runAssertions)
import qualified Assertions.Metric (assertions)
import qualified Assertions.Transform (assertions)

main :: IO ()
main = do
  transform <- Assertions.Transform.assertions
  metric <- Assertions.Metric.assertions
  runAssertions $ transform ++ metric
