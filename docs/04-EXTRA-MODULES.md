# Including Extra Modules

Sometimes you might need to exclude certain directories but still want to import select modules within them. Use the `extraModules` option for this.

## Use Cases

**Workaround for helper modules:**

```nix
extraModules = [
  ./configs/home-manager/modules/applications/zsh/zsh.nix
  # Workaround for helper modules within /zsh/ that should be
  # parsed by the 'zsh.nix' module, not imported directly
];
```

**Import specific modules from excluded directories:**

```nix
extraModules = [
  ./testing/atuin-new-config.nix
  # Only import this module from the otherwise excluded '/testing/' directory
];
```

## How It Works

Modules listed in `extraModules` are appended directly to the `imports` list without any filtering or pattern matching. They bypass all exclusion rules.
