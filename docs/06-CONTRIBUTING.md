# Contributing

Contributions are warmly welcome! Whether it's reporting a bug, suggesting an improvement, or submitting code, your input is valuable.

As a newcomer to Nix and NixOS myself, this project was built as part of my learning journey. While I've aimed for correctness (with lots of help!), there might still be some rough edges or areas where things could be done more idiomatically. Your feedback and contributions are especially appreciated in helping refine the code and documentation!

## How to Contribute

1. **Issues** — Open an issue to discuss bugs, propose new features, or ask questions

2. **Pull Requests** — Feel free to submit pull requests for fixes or improvements
   - The core logic resides in `lib/default.nix`
   - Tests are defined in `tests/default.nix`
   - Please ensure `nix flake check` passes before submitting

## Project Structure

```
modulon/
├── flake.nix          # Flake definition and dev shell
├── lib/
│   └── default.nix    # Core module collection logic
├── tests/
│   └── default.nix    # Test derivations
└── docs/              # Documentation
```

Thank you for considering contributing!
