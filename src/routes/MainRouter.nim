import jester, json
from ../controllers/MainController import MainController

router main:
    get "/search/@str":
        resp MainController.search(@"str")