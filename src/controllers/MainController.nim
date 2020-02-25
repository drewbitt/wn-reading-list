
import ../util/novelupdates
import ../util/lncrawl
import ../util/goodreads
import strutils, json

func index*(): string =
    return "hello"

proc lncrawl(lncrawl_results: seq[LncrawlSearchResult]):
    seq[tuple[title: string, author: string, url: string, num_chapters: string]] =
    # For each novel name matched, we get multiple sites.
    # Strategy: Choose site with highest num chapters. This num of chapters isn't 100% accurate though.
    # TODO: More accurate chapter nums, possibly grabbing from chapter title if available?

    if lncrawl_results.len == 0:
        return

    type FullInfo = object
        info: LncrawlInfoResult
        url: string

    var list : seq[tuple[title: string, author: string, url: string, num_chapters: string]]

    for query in lncrawl_results:
        var highest = 0
        var highestResult: FullInfo
        for item in query.novels:
            let info = lncrawl_get_novel_info(item.url)
            if info.chapters.len > highest:
                highest = info.chapters.len
                highestResult = FullInfo(info: info, url: item.url)

        list.add((title: highestResult.info.title, author: highestResult.info.author,
                       url: highestResult.url, num_chapters: $highest))
    return list

proc nu(nu_results: seq[NUResult]):
    seq[tuple[title: string, author: string, url: string, num_chapters: string]] =
    # Get novel info for each novel and return list of full info

    if nu_results.len == 0:
        return

    var list : seq[tuple[title: string, author: string, url: string, num_chapters: string]]

    for novel in nu_results:
        let info = nu_get_novel_info(novel.url)
        var author_str: string
        if info.author.len > 1:
            # need to concat into one string
            for i in info.author:
                author_str = author_str & i
                if i != info.author[info.author.len - 1]:
                    author_str = author_str & ", "
        else:
            author_str = info.author[0]

        list.add((title: novel.title, author: author_str, url: novel.url, num_chapters: info.num_chapters))

    return list

proc gr(gr_results: seq[GoodreadsResult]): seq[tuple[title: string, author: string, url: string, pages: string]] =
    # Remove JsonNodestuff and get usable data
    # Use page number instead of number of chapters.

    if gr_results.len == 0:
        return

    var list : seq[tuple[title: string, author: string, url: string, pages: string]]

    for novel in gr_results:
        let best_book = novel.best_book
        let book_id = replace($best_book.id["#text"], "\"", "") # Remove JsonNode conversion literal quotes
        let best_book_url = "https://www.goodreads.com/book/show/" & book_id
        let page_nums = goodreads_page_numbers(best_book_url)

        list.add((title: best_book.title, author: best_book.author.name, url: best_book_url, pages: $page_nums))

    return list

proc search*(search_string: string): string =
    # For now, I want: Title, Author, Url, Num chapters
    # Num chapters needs to be string because NU has them as strings (c, v etc.)

    # let gr_results = goodreads_search(search_string)
    let nu_results = nu_search(search_string)
    let lncrawl_results = lncrawl_search(search_string)

    # echo nu(nu_results)
    # echo nu_results
    # echo gr_results
    # echo lncrawl_results

    let results = lncrawl(lncrawl_results)
    return $results
