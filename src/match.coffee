import micromatch from "micromatch"

match = ( glob, value ) ->
  micromatch.isMatch value, glob

export { match }