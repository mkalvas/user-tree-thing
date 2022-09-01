{-# LANGUAGE DeriveTraversable #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Projects.Project
  ( Budget (..),
    Transaction (..),
    Money (..),
    ProjectId (ProjectId),
    ProjectF (..),
    Project,
    project,
    projectGroup,
  )
where

import Data.Decimal (Decimal)
import Data.Generics.Fixplate.Base (Mu (Fix))
import Data.Text (Text)

newtype Money = Money
  { unMoney :: Decimal
  }
  deriving (Show, Eq, Num)

data Budget = Budget
  { budgetIncome :: Money,
    budgetExpenditure :: Money
  }
  deriving (Show, Eq)

data Transaction
  = Sale Money
  | Purchase Money
  deriving (Show, Eq)

newtype ProjectId = ProjectId
  { unProjectId :: Int
  }
  deriving (Show, Eq, Num)

data ProjectF f
  = Project ProjectId Text
  | ProjectGroup Text [f]
  deriving (Show, Eq, Functor, Foldable, Traversable)

type Project = Mu ProjectF

project :: ProjectId -> Text -> Project
project p = Fix . Project p

projectGroup :: Text -> [Project] -> Project
projectGroup name = Fix . ProjectGroup name
