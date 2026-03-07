![Dynamic NixOS Module Importer](.assets/modulon.png)

<p align="center" style="font-size: 1.5em;">Introducing Modulon 🦾</p>

<p align="center" style="font-size: 1.5em;"><em>A plug-and-play module management framework for NixOS flakes</em></p>

<br>

**Works with:** NixOS • macOS (via Home Manager) • Generic GNU/Linux (via Home Manager)

---

## Quick Start

1. **Add the flake input:**

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    modulon = {
      url = "github:cig0/modulon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { modulon, nixpkgs, self, ... }:
    # ... rest of your flake
}
```

2. **Use the library function:**

```nix
let
  system = "x86_64-linux";
  moduleImporter = modulon.lib.${system};
in {
  nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      (moduleImporter { dirs = [ ./modules ]; })
    ];
  };
}
```

That's it! Modulon will automatically discover and import all valid NixOS modules from `./modules`.

---

## Table of Contents

- [Quick Start](#quick-start)
- **Documentation**
  - [How It Works](docs/01-HOW-IT-WORKS.md) — Module discovery process and pattern matching
  - [Configuration](docs/02-CONFIGURATION.md) — Options reference and defaults
  - [Excluding Modules](docs/03-EXCLUDING-MODULES.md) — excludePaths, @MODULON_SKIP tag
  - [Extra Modules](docs/04-EXTRA-MODULES.md) — Including specific modules from excluded paths
  - [Testing](docs/05-TESTING.md) — Running and debugging flake checks
  - [Contributing](docs/06-CONTRIBUTING.md) — How to contribute
- [License](#license)

---

## License

Unless otherwise stated, everything in this repo is covered by the following copyright notice:

```plaintext
Automatic NixOS Module Importer.
Copyright (C) 2024-2026  Martín Cigorraga <cig0.github@gmail.com>

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU Affero General Public License v3 or later, as
published by the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
