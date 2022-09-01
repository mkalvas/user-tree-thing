module Lib
  ( calculateProjectReports,
    drawTreeWith,
    allPermissions,
    anyPermissions,
    prettyAny,
    prettyResult,
    someAuthTree,
    someProject,
  )
where

import Auth.Demo (someAuthTree)
import Auth.PrettyPrint (prettyAny)
import Auth.Reporting (allPermissions, anyPermissions)
import Data.Generics.Fixplate.Draw (drawTreeWith)
import Projects.Demo (someProject)
import Projects.PrettyPrint (prettyResult)
import Projects.Reporting (calculateProjectReports)
