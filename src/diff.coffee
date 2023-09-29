import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import { equal } from "@dashkite/joy/value"

diff = generic
  name:"diff"
  description: "General purpose diff algorithm"

generic diff,
  Type.isObject, 
  Type.isObject,
  ( source, target ) ->
    for key, value of source
      if ! target[ key ]?
        yield { action: "add", key, value }
      else if ! equal target[ key ], value
        yield { action: "update", key, value }
    for key in Object.keys target when ! source[ key ]?
      yield { action: "delete", key }

generic diff,
  Type.isObject, 
  Type.isObject,
  Type.isFunction,
  ( source, target, apply ) ->
      Promise.all do ->
        apply patch for patch from diff source, target
          
generic diff, Type.isObject,
  ({ source, target, patch }) ->
    diff source, target, patch

export { diff }