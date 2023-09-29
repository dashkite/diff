# @dashkite/diff

*Generalized dictionary-based diff*

Diff synchronizes a source with a target using a patch function. The source and target should be dictionaries. Diff provides presets for the filesystem, S3, and DashKite DB (Graphene).

For example, to synchronize the local filesystem with S3, you would write:

```coffeescript
import { diff, FS, S3 } from "@dashkite/diff"

diff
  source: FS.glob glob: "**", root: "build"
  target: S3.glob domain: "foobar.com", glob: "**"
  patch: S3.patch domain: "foobar.com"
```

You can also provide the dictionaries and just iterate through the patches:

```coffeescript
for patch in diff source, target
  console.log patch
```

## Status

Under heavy active development. Not ready for production use.

## Roadmap

- Migrate Presets into their own modules.
- Allow the Preset functions for Graphene to take a byname.
- Add tests (currently tested via other modules that rely on it)

## API

### Common Types

#### Dictionary

An object representing a key-value store that can be represented as a dictionary, such as a filesystem directory or S3 bucket.

#### Source And Target

The store from which (source) and to which (target) we want to synchronize. The source and target are projected into dictionaries to perform the diff. The projection may allow for a *glob* to be applied to filter the values to be included in the diff. When passed as a parameter to the `diff` function, the source or target may be a promise or function returning a dictionary.

#### Glob

A Bash-style glob pattern or array of [glob patterns](https://github.com/mrmlnc/fast-glob#basic-syntax). Typically defaults to `**`.

#### Root

The path relative to which globs are resolved.

#### Patch

An object whose properties specify an action, a key, and, if necessary, a value. The action may be *add, update,* or *delete.* The value property is required for *add* and *update* actions, but not for *delete*. Typically, the value is encoded as a byte array to ensure compatibility between presets such as FS (filesystem) and S3.

#### Patch Function or Handler

A function that applies a patch to a source, like the filesystem or S3.

### diff

**diff source, target**

Given source and target dictionaries, returns an iterator that produces patches.

**diff source, target, patch**
**diff { source, target, patch }** 

Given source and target dictionaries and a patch function, iterates through the patches and invokes the patch function.

### FS

**glob { glob, root }**

Returns a dictionary corresponding to the given *glob* in the directory given by *root* applied to the filesystem.

**patch**

Returns a function that applies a patch to the filesystem.

### S3

**glob { domain, glob }**

Returns a dictionary corresponding to the given *glob* applied to the S3 bucket for the given domain.

- **domain:** a domain name corresponding to an S3 bucket.

**patch { domain }**

Returns a function that applies a patch to an S3 bucket for the given domain..

### Graphene

**glob { collection, glob }**

Returns a dictionary corresponding to the given glob applied to the given collection.

**patch { collection }**

Returns a function that applies a patch to the given collection.
