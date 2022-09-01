module Auth.PrettyPrint (prettyAny) where

import Auth.AuthTree (AuthTreeF (Permission, Role))
import Auth.Reporting (AuthReport (authorized))
import Data.Generics.Fixplate.Base (Ann (Ann))
import Text.Printf (printf)

prettyAny :: (AuthReport r) => Ann AuthTreeF r a -> String
prettyAny (Ann report tree) =
  case tree of
    Permission p -> printf "%s: %s" p (show $ authorized report)
    Role name _ -> printf "%s: %s" name (show $ authorized report)
