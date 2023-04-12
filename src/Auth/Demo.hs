{-# LANGUAGE OverloadedStrings #-}

module Auth.Demo (demoAuthTree) where

import Auth.AuthTree (AuthTree, permission, role)

demoAuthTree :: AuthTree
demoAuthTree = role "Super Admin" [createAll, deleteAll, admin]
  where
    admin = role "Admin" [readAll, updateAll, createCompany, deleteCompany, companyAdmin, user]
    companyAdmin = role "Company Admin" [readCompany, updateCompany, createUser, readUser, updateUser, deleteUser]
    user = role "User" [readUser, updateUser]
    createAll = permission "create-all"
    readAll = permission "read-all"
    updateAll = permission "update-all"
    deleteAll = permission "delete-all"
    createCompany = permission "create-company"
    readCompany = permission "read-company"
    updateCompany = permission "update-company"
    deleteCompany = permission "delete-company"
    createUser = permission "create-user"
    readUser = permission "read-user"
    updateUser = permission "update-user"
    deleteUser = permission "delete-user"
