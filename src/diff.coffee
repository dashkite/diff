import * as Fn from "@dashkite/joy/function"
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

normalize = generic
  name: "normalize"
  description: "normalize a promise or function into promise returning a value"

generic normalize, Type.isObject, Fn.identity  

generic normalize, Type.isPromise, Fn.identity

generic normalize, Type.isFunction, ( f ) -> f()

generic diff,
  Type.isDefined, 
  Type.isDefined,
  Type.isFunction,
  ( source, target, apply ) ->
    diff ( await normalize source ), 
      ( await normalize target ), 
      apply

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