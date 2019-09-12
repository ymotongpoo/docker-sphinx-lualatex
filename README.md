# docker-sphinx-lualatex

Dockerfile to create a docker image with the following environment:

* [Sphinx](http://www.sphinx-doc.org/en/master/)
* [*diag series](http://blockdiag.com/)
* LuaLaTeX

For the configuration of `conf.py` for LuaLaTeX, please find an example in `example/source/conf.py`.

# How to try this docker image

```
$ cd example
$ docker run -v $PWD:/workdir -t ymotongpoo/sphinx-lualatex:buster-slim-2.2.0 make latexpdf
```

# Special thanks

* Yoshimura Yuu (@y-yu)