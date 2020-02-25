import requests
import traceback
from pyquery import PyQuery as pq

req = requests.Session()

# Returns total page numbers from scraping a goodreads book url
def getPageNumber(book_url):
    html = ''
    try:
        for i in range(0, 5):
            try:
                html = requests.get(
                    url=book_url,
                    timeout=10
                )
                break
            except Exception:
                print(traceback.format_exc())
        req.close()

        nu = pq(html.text)

        page_number = nu.find("span[itemprop=numberOfPages]")
        if page_number:
            if "pages" in page_number[0].text:
                return int(page_number[0].text.split(" pages")[0])
            else:
                # not sure this would ever happen, usually contains word "pages"
                return page_number[0].text
        else:
            return

        return page_number
    except Exception as e:
        print(e)
        req.close()
        return None
