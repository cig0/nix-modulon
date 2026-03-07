# Configuration Options

The module importer function accepts an attribute set with these parameters:

| Option         | Type            | Description                                                                                                | Default |
|----------------|-----------------|-----------------------------------------------------------------------------------------------------------|---------|
| `dirs`         | List of paths   | **Required.** Directories to scan recursively for modules.                                                | `[]`    |
| `excludePaths` | List of strings | Path fragments/patterns to exclude from scanning (e.g., `"/tests/"`, `".git/"`, `"experimental"`).        | `[]`    |
| `extraModules` | List of paths   | Specific module files to include directly. Useful for including modules within an otherwise excluded path.| `[]`    |

## Example Usage

```nix
(moduleImporter {
  dirs = [ ./modules ./profiles ];
  excludePaths = [ "/tests/" "/experimental/" ];
  extraModules = [ ./special/important-module.nix ];
})
```

## Default Excluded Files

Modulon automatically excludes these filenames (exact match):

- `configuration.nix`
- `flake.nix`
- `hardware-configuration.nix`
- `home.nix`

And these path patterns (infix match):

- `.git/`
- `/tests/`

See `lib/default.nix` for the complete list.
