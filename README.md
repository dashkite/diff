# @dashkite/diff

*Generalized dictionary-based diff*

Diff synchronizes a source with a target using a patch function. The source and target should be dictionaries. Diff provides presets for the filesystem, S3, and DashKite DB (Graphene).

For example, to synchronize the local filesystem with S3, you would write:

```coffeescript
import { diff, FS, S3 } from "@dashkite/diff"

diff
  source: await FS.glob glob: "**", root: "build"
  target: await S3.glob domain: "foobar.com", glob: "**"
  patch: S3.patch domain: "foobar.com"
```

## API

### diff

**diff source, target**

Given source and target dictionaries, produces patches.

**diff source, target, patch**
**diff { source, target, patch }** 

Given source and target dictionaries and a patch function, invokes the patch function on each patch.

### FS

**glob { glob, root }**

Returns a dictionary of files corresponding to the given *glob* in the directory given by *root*.

**patch { glob, root }**

Returns a function that applies a patch to the filesystem for files matching the given *glob* in the directory given by *root.*

### S3

**glob { domain, glob, root }**

Returns a dictionary of files corresponding to the given *glob* in the directory given by *root*.

**patch { glob }**

Returns a function that applies a patch to the filesystem for files matching the given *glob*.
