import nimpy

let lncrawl = pyImport("lncrawl")

type
     LncrawlSearchResultNovels* = object
          title*: string
          url*: string
          info*: string
type
     LncrawlSearchResult* = object
          id*: string
          title*: string
          novels*: seq[LncrawlSearchResultNovels]
type
     LncrawlInfoResultNovels* = object
          id*: int
          volume*: int
          url*: string
          title*: string
          volume_title*: string
type
     LncrawlInfoResultVolumes* = object
          id*: int
          title*: string
          chapter_count*: int
          final_chapter*: int
          start_chapter*: int
type
     LncrawlInfoResult* = object
          title*: string
          cover*: string
          author*: string
          chapters*: seq[LncrawlInfoResultNovels]
          volumes*: seq[LncrawlInfoResultVolumes]


# Returns sequence of SearchResult objects from querying all lncrawl sites for novels
proc lncrawl_search*(search_string: string): seq[LncrawlSearchResult]=
     try:
          return lncrawl.search(search_string).to(seq[LncrawlSearchResult])
     except: # Gives generic exception if nothing found
          return

# Returns InfoResult object containing novel details from querying the url
proc lncrawl_get_novel_info*(url: string): LncrawlInfoResult=
     try:
          return lncrawl.get_novel_info(url).to(LncrawlInfoResult)
     except:
          return
