import traceback
from pyquery import PyQuery as pq
import cloudscraper

scraper = cloudscraper.create_scraper()

# TODO: Actually, the share doesn't work
# Not closing session so that they can share a session if cloudfare is enabled;
# this exits immediately so doesn't matter if I close

def getLightNovelURL(searchText):
    html = ''
    try:
        searchText = searchText.replace(' ', '+')
        try:
            html = scraper.get(
                url="http://www.novelupdates.com/?s={searchText}"
            )
        except Exception:
            print(traceback.format_exc())

        nu = pq(html.text)

        lnList = []

        for thing in nu.find('.search_title > a'):
            title = thing.text
            url = pq(thing).attr['href']

            if title:
                data = {'title': title,
                        'url': url}
                lnList.append(data)
        return lnList
    except Exception as e:
        print(e)
        return None

# Returns dict of author and num chapters
def getNovelInfo(novel_url):
    html = ''
    try:
        try:
            html = scraper.get(
                url=novel_url
            )
        except Exception:
            print(traceback.format_exc())

        nu = pq(html.text)

        authorList = []

        for author in nu.find('#showauthors > a'):
            name = author.text
            if name:
                authorList.append(name)

        latest_chapter = nu.find("a.chp-release")[0].text

        return {'author': authorList, 'num_chapters': latest_chapter}
    except Exception as e:
        print(e)
        return None
