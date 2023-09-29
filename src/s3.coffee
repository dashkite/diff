import {
  getObject
  putObject
  deleteObject
  listObjects
} from "@dashkite/dolores/bucket"

import { match } from "./match"

S3 =

  glob: ({ domain, glob }) ->
    dictionary = {}
    for { Key } from await listObjects domain when match Key, glob
      { content } = await getObject domain, Key
      dictionary[ Key ] = content
    dictionary


  patch: ({ domain }) ->
 
    do ( { handlers } = {}) ->

      handlers = 

        add: ( key, value ) -> 
          putObject domain, key, value
        
        update: ( key, value ) ->
          putObject domain, key, value
        
        delete: ( key ) ->
          deleteObject domain, key

      ({ action, key, value }) ->
        handlers[ action ] key, value


export { S3 }