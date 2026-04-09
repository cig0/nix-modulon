![Dynamic NixOS Module Importer](.assets/images/modulon.png)

<p align="center" style="font-size: 1.5em;"><strong>Introducing Modulon 🦾</strong></p>

<p align="center"><em>A plug-and-play module management framework for NixOS and Nix flakes</em></p>

<p align="center">Works with NixOS • GNU/Linux distros & macOS via Home Manager</p>

<br>

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

That's it! Modulon will automatically discover and import all valid NixOS and Nix modules from `./modules`

<br>

## Table of Contents

- [How It Works](.assets/docs/01-HOW-IT-WORKS.md) — Module discovery process and pattern matching
- [Configuration](.assets/docs/02-CONFIGURATION.md) — Options reference and defaults
- [Excluding Modules](.assets/docs/03-EXCLUDING-MODULES.md) — excludePaths, @MODULON_SKIP tag
- [Extra Modules](.assets/docs/04-EXTRA-MODULES.md) — Including specific modules from excluded paths
- [Testing](.assets/docs/05-TESTING.md) — Running and debugging flake checks
- [Contributing](.assets/docs/06-CONTRIBUTING.md) — How to contribute

<br>

## License

Unless otherwise stated, everything in this repo is covered by the following copyright notice:

```plaintext
Modulon - An automatic NixOS/Nix Module Importer.
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
