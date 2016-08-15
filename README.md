# JavaScript interop with Elm

This is an example of possible interop between elm and jquery-ui calendar

See more on the matter in the official docs for [JavaScript Interop] [ports]

## Building the example

Since this example features port module, it is impossible to build it with [elm-reactor](https://github.com/elm-lang/elm-reactor)

You have to explicitly specify the `--output=index.js`

Depends on [Cmd.Extra](http://package.elm-lang.org/packages/shmookey/cmd-extra/1.0.0/Cmd-Extra)

```sh
$ elm-package istall -y
$ elm-make Main.elm --output=index.js
```

[ports]: <http://guide.elm-lang.org/interop/javascript.html>
