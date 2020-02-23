# Package

version       = "1.0.0"
author        = "drewbitt"
description   = ""
license       = "Apache"
srcDir        = "src"
binDir        = "bin"
bin           = @["app"]


# Dependencies

requires "nim >= 1.0.2", "jester", "norm >= 1.0.16", "dotenv >= 1.1.1, nimpy >= 0.1.0"

# Tasks

task createdb, "Create DB tables from user defined types":
  exec "nim c -r src/models/models.nim"
  rmFile "src/models/models".toExe()
