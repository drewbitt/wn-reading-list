import jester, json
from ../controllers/MainController import MainController

router main:
    get "/search/@str":
        resp(Http200, {"Access-Control-Allow-Origin":"*"}, MainController.search(@"str").to(string))