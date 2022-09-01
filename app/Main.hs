module Main (main) where

import Lib
  ( allPermissions,
    anyPermissions,
    calculateProjectReports,
    drawTreeWith,
    prettyAny,
    prettyResult,
    someAuthTree,
    someProject,
  )

main :: IO ()
main = do
  pr <- calculateProjectReports someProject
  drawTreeWith prettyResult pr
  putStrLn "anyTree"
  anyTree <- anyPermissions someAuthTree
  drawTreeWith prettyAny anyTree
  putStrLn "allTree"
  allTree <- allPermissions someAuthTree
  drawTreeWith prettyAny allTree
