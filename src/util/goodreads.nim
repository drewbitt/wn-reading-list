
import dotenv, nimpy, os, json

let env = initDotEnv()
env.load()

let pysys = pyImport("sys")
discard pysys.path.append(joinPath(getCurrentDir(),"/src/util"))

let gr_pages = pyImport("goodreads")
let gr = pyImport("goodreads_api_client")

let client = gr.Client(developer_key=os.getEnv("GOODREADS_DEVELOPER_KEY"))

type
    GoodreadsAuthor* = object
        id*: JsonNode
        name*: string
type
    GoodreadsBookResult* = object
        id*: JsonNode
        title*: string
        author*: GoodreadsAuthor
        image_url*: string
        small_image_url*: string
type
    GoodreadsResult* = object
        id*: JsonNode
        books_count*: JsonNode
        ratings_count*: JsonNode
        text_reviews_count*: JsonNode
        original_publication_year*: JsonNode
        original_publication_month*: JsonNode
        original_publication_day*: JsonNode
        average_rating*: string
        best_book*: GoodreadsBookResult

# TODO: Avoid usage of PyObject -> JsonNode -> Object containing JsonNodes..., or cleanup with additional
# object that looks at JsoNode type and converts text to that type

# Returns sequence of Result objects containing books from a goodreads search.
# JsonNode objects field example:
    # "@type": "integer",
    # "#text": "340"
# To access JsonNode inner values, do goodreads_search(query)[index].id["#text"], replacing id with the field you want
proc goodreads_search*(search_string: string): seq[GoodreadsResult] =
    try:
        let results = client.search_book(search_string).to(JsonNode)
        try:
            if results["results"].to(string) == "None":
                return
        except:
            discard
        let deep_results = results["results"]["work"]
        return to(deep_results, seq[GoodreadsResult])
    except:
        let
            e = getCurrentException()
            msg = getCurrentExceptionMsg()
        echo "Got exception ", repr(e), " with message ", msg
        return

# Returns total num of pages in goodreads book from srcaping URL since not in API
proc goodreads_page_numbers*(url: string): int =
    try:
        return gr_pages.getPageNumber(url).to(int)
    except:
        return
