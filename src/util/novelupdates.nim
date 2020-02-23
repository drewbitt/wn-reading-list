
import nimpy

let nu = pyImport("novelupdates")
type
    Result = object
        title: string
        url: string

# Returns sequence of Result objects from novelupdates search
proc nu_search(search_string: string): seq[Result] =
    nu.getLightNovelURL(search_string).to(seq[Result])
