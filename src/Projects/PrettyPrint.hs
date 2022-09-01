module Projects.PrettyPrint (prettyResult) where

import Data.Decimal (roundTo)
import Data.Generics.Fixplate.Base (Ann (Ann))
import Projects.Project (Money (Money), ProjectF (..), ProjectId (ProjectId))
import Projects.Reporting (Report (..))
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

prettyResult :: Ann ProjectF Report a -> String
prettyResult (Ann report project') =
  case project' of
    Project (ProjectId p) name ->
      printf "%s (%d): %s" name p (prettyReport report)
    ProjectGroup name _ ->
      printf "%s: %s" name (prettyReport report)
