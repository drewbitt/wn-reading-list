
import ../util/novelupdates
import ../util/lncrawl
import ../util/goodreads

func index*(): string =
    return "hello"

proc lncrawl(lncrawl_results: seq[LncrawlSearchResult]):
    seq[tuple[title: string, author: string, url: string, num_chapters: int]] =
    # For each novel name matched, we get multiple sites.
    # Strategy: Choose site with highest num chapters. This num of chapters isn't 100% accurate though.
    # TODO: More accurate chapter nums, possibly grabbing from chapter title if available?

    type FullInfo = object
        info: LncrawlInfoResult
        url: string

    var list : seq[tuple[title: string, author: string, url: string, num_chapters: int]]

    for query in lncrawl_results:
        var highest = 0
        var highestResult: FullInfo
        for item in query.novels:
            let info = lncrawl_get_novel_info(item.url)
            if info.chapters.len > highest:
                highest = info.chapters.len
                highestResult = FullInfo(info: info, url: item.url)

        list.add((title: highestResult.info.title, author: highestResult.info.author,
                       url: highestResult.url, num_chapters: highest))
    return list


proc search*(search_string: string): string =
    # For now, I want: Title, Author, Url, Num chapters

    let nu_results = nu_search(search_string)
    let gr_results = goodreads_search(search_string)
    let lncrawl_results = lncrawl_search(search_string)

    echo lncrawl(lncrawl_results)

    echo nu_results
    echo gr_results
    # echo lncrawl_results

    return "Testing"
