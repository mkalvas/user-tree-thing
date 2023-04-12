{-# LANGUAGE OverloadedStrings #-}

module Projects.Demo (demoProject) where

import Data.Generics.Fixplate.Draw ()
import Projects.Task (Task, task, taskGroup)

demoProject :: Task
demoProject = taskGroup "Epic" [taskOne, taskTwo, bigTask]
  where
    taskOne = task 1 "Task 1"
    taskTwo = task 2 "Task 2"
    bigTask = taskGroup "Big Task" [subTaskOne, subTaskTwo]
    subTaskOne = task 4 "Sub-Task 1"
    subTaskTwo = task 5 "Sub-Task 2"
