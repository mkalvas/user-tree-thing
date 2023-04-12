module Lib
  ( accPerms,
    allAuth,
    anyAuth,
    calculateProjectReports,
    demoAuthTree,
    demoProject,
    drawTreeWith,
    prettyAuth,
    prettyResult,
    showAuthTree,
  )
where

import Auth.Demo (demoAuthTree)
import Auth.PrettyPrint (prettyAuth, showAuthTree)
import Auth.Reporting (accPerms, allAuth, anyAuth)
import Data.Generics.Fixplate.Draw (drawTreeWith)
import Projects.Demo (demoProject)
import Projects.PrettyPrint (prettyResult)
import Projects.Reporting (calculateProjectReports)
