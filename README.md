# WN-Reading-List-Backend

[Frontend](https://gitgud.io/wn-reading-list/wn-reading-list-frontend/) | [Frontend Github mirror](https://github.com/wn-reading-list/wn-reading-list-frontend)

[Jester](https://github.com/dom96/jester) app that utilizes several Python libraries using [nimpy](https://github.com/yglukhov/nimpy) to search for books from various sources: Novelupdates, Goodreads, and all 20+ supported sites of lightnovel-crawler.

## Why?

First project in nim. Using nim as the "glue" language for python instead of the other way around was an interesting anti-pattern to explore.

## Setup

Depends on the Python package [lightnovel-crawler](https://github.com/drewbitt/lightnovel-crawler). It has been forked to remove console prints and allow for module usage. Install by either using `requirements.txt` or by going inside the `lightnovel-crawler` directory and running `python setup.py install`.

Additionally, create an .env file with the following variables:

```
GOODREADS_DEVELOPER_KEY=KEY_HERE
```

## Installation & Usage

Use the package manager [nimble](https://pip.pypa.io/en/stable/).

Build:

``` bash
nimble build app
```

Run:

```bash
nimble run app
```

Before deployment in production, uncomment `-d:release` in `nim.cfg`

## License

[GNU](LICENSE.md)

## Contributing

Bug reporting is welcome on the Github mirror, but all code contributing should be on the main project. Please be sure to check there for issues before reporting on Github.

## Contact

Project Link: [https://gitgud.io/wn-reading-list/wn-reading-list-backend](https://gitgud.io/wn-reading-list/wn-reading-list-backend)

Mirrored to: [https://github.com/wn-reading-list/wn-reading-list-backend](https://github.com/wn-reading-list/wn-reading-list-backend)
