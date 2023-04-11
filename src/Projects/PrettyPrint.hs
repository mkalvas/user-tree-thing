module Projects.PrettyPrint (prettyResult) where

import Data.Decimal (roundTo)
import Data.Generics.Fixplate.Base (Ann (Ann))
import Projects.Reporting (Report (..))
import Projects.Task (Money (Money), TaskF (..), TaskId (TaskId))
import Text.Printf (printf)

prettyMoney :: Money -> String
prettyMoney (Money d) = sign ++ show (roundTo 2 d)
  where
    sign = if d > 0 then "+" else ""

prettyReport :: Report -> String
prettyReport r =
  printf
    "Budget: %s, Net: %s, Difference: %s"
    (prettyMoney (budgetProfit r))
    (prettyMoney (netProfit r))
    (prettyMoney (difference r))

prettyResult :: Ann TaskF Report a -> String
prettyResult (Ann report task') =
  case task' of
    Task (TaskId p) name ->
      printf "%s (%d): %s" name p (prettyReport report)
    TaskGroup name _ ->
      printf "%s: %s" name (prettyReport report)
