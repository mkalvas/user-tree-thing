{-# LANGUAGE FlexibleInstances #-}

module Auth.Reporting (accPerms, allAuth, anyAuth) where

import Auth.AuthTree
import Data.Foldable (fold)
import Data.Generics.Fixplate (Attr, annMap, synthetise)
import Data.Monoid (All (All, getAll), Any (Any, getAny))

type AccAuthTree = Attr AuthTreeF PermissionList

type BoolAuthTree = Attr AuthTreeF Bool

accPerms :: AuthTree -> AccAuthTree
accPerms = synthetise rollup
  where
    rollup (Permission p) = [p]
    rollup (Role _ permissions) = fold permissions

allAInB :: PermissionList -> PermissionList -> Bool
allAInB a b = getAll $ foldMap (\x -> All (x `elem` b)) a

allAuth :: PermissionList -> AccAuthTree -> BoolAuthTree
allAuth perms = annMap (allAInB perms)

anyAInB :: PermissionList -> PermissionList -> Bool
anyAInB a b = getAny $ foldMap (\x -> Any (x `elem` b)) a

anyAuth :: PermissionList -> AccAuthTree -> BoolAuthTree
anyAuth perms = annMap (anyAInB perms)
