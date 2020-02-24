
import nimpy, os

let pysys = pyImport("sys")
discard pysys.path.append(joinPath(getCurrentDir(),"/src/util"))
let nu = pyImport("novelupdates")
type
    NUResult* = object
        title: string
        url: string

# Returns sequence of Result objects from novelupdates search
# Limit 25 results (first page)
proc nu_search*(search_string: string): seq[NUResult] =
    nu.getLightNovelURL(search_string).to(seq[NUResult])

# TODO: Get chapter num/author data
