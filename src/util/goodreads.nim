
import dotenv, nimpy, os, json

let env = initDotEnv()
env.load()

let gr = pyImport("goodreads_api_client")
let client = gr.Client(developer_key=os.getEnv("GOODREADS_DEVELOPER_KEY"))

type
    GoodreadsAuthor* = object
        id: JsonNode
        name: string
type
    GoodreadsBookResult* = object
        id: JsonNode
        title: string
        author: GoodreadsAuthor
        image_url: string
        small_image_url: string
type
    GoodreadsResult* = object
        id: JsonNode
        books_count: JsonNode
        ratings_count: JsonNode
        text_reviews_count: JsonNode
        original_publication_year: JsonNode
        original_publication_month: JsonNode
        average_rating: string
        best_book: GoodreadsBookResult

# TODO: Avoid usage of PyObject -> JsonNode -> Object containing JsonNodes..., or cleanup with additional
# object that looks at JsoNode type and converts text to that type

# Returns sequence of Result objects containing books from a goodreads search.
# JsonNode objects field example:
    # "@type": "integer",
    # "#text": "340"
# To access JsonNode inner values, do goodreads_search(query)[index].id["#text"], replacing id with the field you want
proc goodreads_search*(search_string: string): seq[GoodreadsResult] =
    let results = client.search_book(search_string).to(JsonNode)
    if results["results"].to(string) == "None":
        return
    let deep_results = results["results"]["work"]
    to(deep_results, seq[GoodreadsResult])
