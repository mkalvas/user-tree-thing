module Auth.Database (getUserPermission) where

import Auth.AuthTree (PermissionName)
import System.Random (getStdRandom, randomR)

randomBool :: IO Bool
randomBool = getStdRandom (randomR (False, True))

getUserPermission :: PermissionName -> IO Bool
getUserPermission _ = do randomBool
