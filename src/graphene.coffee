import { match } from "./match"

# convert to (encode) and from (decode) bytes
# encoder api defaults to utf8
encode = ( text ) -> ( new TextEncoder ).encode text
decode = ( bytes ) -> ( new TextDecoder ).decode bytes

Graphene =

  glob: ({ collection, glob }) ->
    dictionary = {}
    items = await collection.metadata.list()
    for item in items when match glob, item.entry
      dictionary[ item.entry ] = encode item.content
    dictionary

  patch: ({ collection }) ->

    do ({ handlers } = {}) ->

      handlers =

        add: ( key, value ) ->
          collection.put key, decode value
        
        update: ( key, value ) ->
          collection.put key, decode value

        delete: ( key ) ->
          collection.delete key

      ({ action, key, value }) ->
        handlers[ action ] key, value

export { Graphene }