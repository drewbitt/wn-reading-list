import nimpy

let lncrawl = pyImport("lncrawl")

type
     SearchResultNovels = object
          title: string
          url: string
          info: string
type
     SearchResult = object
          id: string
          title: string
          novels: seq[SearchResultNovels]
type
     InfoResultNovels = object
          id: int
          volume: int
          url: string
          title: string
          volume_title: string
type
     InfoResultVolumes = object
          id: int
          title: string
          chapter_count: int
          final_chapter: int
          start_chapter: int
type
     InfoResult = object
          title: string
          cover: string
          author: string
          chapters: seq[InfoResultNovels]
          volumes: seq[InfoResultVolumes]


# Returns sequence of SearchResult objects from querying all lncrawl sites for novels
proc lncrawl_search*(search_string: string): seq[SearchResult] =
     lncrawl.search(search_string).to(seq[SearchResult])

# Returns InfoResult object containing novel details from querying the url
proc lncrawl_get_novel_info*(url: string): InfoResult =
     lncrawl.get_novel_info(url).to(InfoResult)
