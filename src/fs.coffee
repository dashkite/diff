import $FS from "node:fs/promises"
import Path from "node:path"

import * as Glob from "fast-glob"

glob = ( options ) ->
  Glob.glob options.glob, {
    cwd: options.root
    options...
  }

FS =

  glob: ( options ) ->
    dictionary = {}
    for path from await glob options
      _path = Path.join options.root, path
      content = new Uint8Array await $FS.readFile _path
      dictionary[ path ] = content
    dictionary

  patch: ( options ) ->
    # TODO
    ( patch ) ->

export { FS }