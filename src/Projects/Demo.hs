{-# LANGUAGE OverloadedStrings #-}

module Projects.Demo (someProject) where

import Data.Generics.Fixplate.Draw ()
import Projects.Project (Project, project, projectGroup)

someProject :: Project
someProject = projectGroup "Sweden" [stockholm, gothenburh, malmo]
  where
    stockholm = project 1 "Stockholm"
    gothenburh = project 2 "Gothenburg"
    malmo = projectGroup "Malmo" [city, limhamn]
    city = project 4 "Malmo City"
    limhamn = project 5 "Limhamn"
