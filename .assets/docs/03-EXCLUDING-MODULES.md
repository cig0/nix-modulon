# Excluding Modules

You have several ways to prevent files or directories from being imported.

## Using excludePaths

Provide path fragments or patterns when calling the module importer function. This is the most flexible method.

Patterns use **infix matching**, meaning `/foo/` will match anywhere in the path (e.g., `/bar/foo/baz.nix`). Using leading/trailing slashes like `/dirname/` is recommended for excluding directories reliably.

**Examples:**

Exclude any module(s) with the name `test.nix`, and any path containing `/experimental/`:

```nix
excludePaths = [ "tests.nix" "/experimental/" ];
```

If you have modules with the same name and want to exclude specific ones:

```nix
excludePaths = [ "path/to/tests.nix" "path/to/experimental/" ];
```

## Using @MODULON_SKIP Tag

_Added in v0.1.1_

Add `@MODULON_SKIP` anywhere in your module file (recommended at the top), and Modulon will skip it without needing to modify the exclusion list.

This is especially useful when you have a module structure like this:

```
.
├── packages
│   ├── baseline.nix
│   ├── cli.nix
│   ├── default.nix    ← Add @MODULON_SKIP here
│   ├── gui.nix
│   └── tryout.nix
```

Without this tag, you'd need to exclude the entire directory and then re-include specific files:

```nix
(libModulon {
  excludePaths = [ "/applications/packages/" ];
  extraModules = [
    "${self}/configs/nixos/modules/applications/packages/default.nix"
  ];
})
```

With the tag, just add `@MODULON_SKIP` to the file you want to skip.

## Other Methods

- **Rename Files** — Change a module's filename extension (e.g., `.nix.dis`) so it's no longer picked up
- **Directory Structure** — Place modules you don't want automatically imported outside the directories listed in `dirs`
