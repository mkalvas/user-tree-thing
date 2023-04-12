{-# LANGUAGE OverloadedStrings #-}

module Auth.PrettyPrint (prettyAuth, showAuthTree) where

import Auth.AuthTree (AuthTreeF (Permission, Role))
import Data.Generics.Fixplate.Base (Ann (Ann))
import Text.Printf (printf)

prettyAuth :: (Show r) => Ann AuthTreeF r a -> String
prettyAuth (Ann report tree) =
  case tree of
    Role name _ -> printf "%s: %s" name (show report)
    Permission _ -> ""

showAuthTree :: AuthTreeF a -> String
showAuthTree (Permission p) = printf "%s" p
showAuthTree (Role name _) = printf "%s" name
