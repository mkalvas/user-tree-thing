{-# LANGUAGE DeriveTraversable #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Projects.Task
  ( Budget (..),
    Transaction (..),
    Money (..),
    TaskId (TaskId),
    TaskF (..),
    Task,
    task,
    taskGroup,
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

newtype TaskId = TaskId
  { unTaskId :: Int
  }
  deriving (Show, Eq, Num)

data TaskF f
  = Task TaskId Text
  | TaskGroup Text [f]
  deriving (Show, Eq, Functor, Foldable, Traversable)

type Task = Mu TaskF

task :: TaskId -> Text -> Task
task p = Fix . Task p

taskGroup :: Text -> [Task] -> Task
taskGroup name = Fix . TaskGroup name
