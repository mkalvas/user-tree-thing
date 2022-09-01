module Auth.Reporting (AuthReport (..), allPermissions, anyPermissions) where

import Auth.AuthTree
import qualified Auth.Database as DB
import Data.Foldable (fold)
import Data.Generics.Fixplate.Attributes (synthetiseM)
import Data.Generics.Fixplate.Base (Attr)
import Data.Monoid (All (All, getAll), Any (Any, getAny))

class AuthReport a where
  authorized :: a -> Bool

type AnyAuthorization = Attr AuthTreeF Any

instance AuthReport Any where
  authorized = getAny

anyPermissions :: AuthTree -> IO AnyAuthorization
anyPermissions = synthetiseM rollup
  where
    rollup (Permission p) = Any <$> DB.getUserPermission p
    rollup (Role _ permissions) = pure (fold permissions)

type AllAuthorization = Attr AuthTreeF All

instance AuthReport All where
  authorized = getAll

allPermissions :: AuthTree -> IO AllAuthorization
allPermissions = synthetiseM rollup
  where
    rollup (Permission p) = All <$> DB.getUserPermission p
    rollup (Role _ permissions) = pure (fold permissions)
