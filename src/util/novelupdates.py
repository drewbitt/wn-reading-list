'''
NovelUpdates.py
Handles all NovelUpdates information
'''

# Copyright (C) 2018  Nihilate
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

import difflib

import requests
import traceback
from pyquery import PyQuery as pq

req = requests.Session()


def getLightNovelURL(searchText):
    html = ''
    try:
        searchText = searchText.replace(' ', '+')
        for i in range(0, 5):
            try:
                html = requests.get(
                    url=f"http://www.novelupdates.com/?s={searchText}",
                    timeout=10
                )
                break
            except Exception:
                print(traceback.format_exc())
        req.close()

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
        req.close()
        return None
