{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Lib
  ( accPerms,
    allAuth,
    anyAuth,
    calculateProjectReports,
    demoAuthTree,
    demoProject,
    drawTreeWith,
    prettyAuth,
    prettyResult,
    showAuthTree,
  )

main :: IO ()
main = do
  pr <- calculateProjectReports demoProject
  drawTreeWith prettyResult pr

  putStrLn "Roles and Permissions"
  drawTreeWith showAuthTree demoAuthTree
  let accTree = accPerms demoAuthTree

  putStrLn "anyPermissions [\"create-all\", \"create-user\"] demoAuthTree"
  let anyTree = anyAuth ["create-all", "create-user"] accTree
  drawTreeWith prettyAuth anyTree

  putStrLn "allPermissions [\"create-company\", \"create-user\"] demoAuthTree"
  let allTree = allAuth ["create-company", "create-user"] accTree
  drawTreeWith prettyAuth allTree
