
import nimpy, os

let pysys = pyImport("sys")
discard pysys.path.append(joinPath(getCurrentDir(),"/src/util"))
let nu = pyImport("novelupdates")

type
    NUResult* = object
        title*: string
        url*: string
type
    NUInfoResult* = object
        author*: seq[string]
        num_chapters*: string

# Returns sequence of Result objects from novelupdates search
# Limit 25 results (first page)
proc nu_search*(search_string: string): seq[NUResult] =
    try:
        return nu.getLightNovelURL(search_string).to(seq[NUResult])
    except:
        return

# Returns NUInfoResult object containing author and latest chapter(string on NU)
proc nu_get_novel_info*(url: string): NUInfoResult =
    try:
        return nu.getNovelInfo(url).to(NUInfoResult)
    except:
        return
