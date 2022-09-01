{-# LANGUAGE OverloadedStrings #-}

module Auth.Demo (someAuthTree) where

import Auth.AuthTree (AuthTree, permission, role)

someAuthTree :: AuthTree
someAuthTree = role "Super Admin" [admin, companyAdmin, deleteAll]
  where
    admin = role "Admin" [companyAdmin, readAll, writeAll]
    companyAdmin = role "Company Admin" [readCompany, writeCompany]
    readAll = permission "read-all"
    writeAll = permission "write-all"
    readCompany = permission "read-company"
    writeCompany = permission "write-company"
    deleteAll = permission "delete-all"

-- Have tree of things bottom up
-- Next need to create a User with a role tree attached to it and do 2 things
--   1. answer yes or no to "can I do this?"
--   2. create tree/list of all things I can do (top down)
-- Should I invert the tree or invert the algorithm?

-- Also this doesn't "reuse" the common children, they're duplicated so we'd
-- want something different. Probably best to go back to manual recursion
-- instead of free monads until I sort this stuff out.
