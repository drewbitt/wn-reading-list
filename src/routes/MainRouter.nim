import jester, json
from ../controllers/MainController import MainController

router main:
    get "/search/@str":
        try:
            resp(Http200, {"Access-Control-Allow-Origin":"*"}, MainController.search(@"str").to(string))
        except Exception as e:
            let
                e = getCurrentException()
                msg = getCurrentExceptionMsg()
            echo "Got exception in main router search", repr(e), " with message ", msg