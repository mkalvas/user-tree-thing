{-# LANGUAGE DeriveTraversable #-}

module Auth.AuthTree
  ( AuthTreeF (..),
    AuthTree,
    permission,
    PermissionName,
    role,
    RoleName,
  )
where

import Data.Generics.Fixplate.Base (Mu (Fix))
import Data.Text (Text)

type PermissionName = Text

type RoleName = Text

data AuthTreeF f
  = Permission PermissionName
  | Role RoleName [f]
  deriving (Show, Eq, Functor, Foldable, Traversable)

type AuthTree = Mu AuthTreeF

permission :: PermissionName -> AuthTree
permission = Fix . Permission

role :: RoleName -> [AuthTree] -> AuthTree
role name = Fix . Role name
