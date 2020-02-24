import jester
from ../controllers/MainController import MainController

router main:
    get "/":
        resp MainController.index()
    get "/test":
        resp "test"
    get "/search/@search_string":
        resp MainController.search(@"search_string")
