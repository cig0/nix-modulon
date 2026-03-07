# Potential Improvements

This document tracks potential improvements for future versions of Modulon.

## Performance

### Lazy file content evaluation

**Issue:** `builtins.readFile` is called for every `.nix` file during evaluation. For large repositories with many Nix files, this could slow down `nix flake check` and other evaluation-heavy operations.

**Potential solution:** 
- Implement lazy evaluation of file contents (only read when needed)
- Consider caching mechanisms for repeated evaluations
- This would add complexity, so only pursue if performance becomes a real issue

**Severity:** Low - only affects very large codebases

---

## Pattern Detection

### ~~Reduce false positives~~ ✅ Fixed

~~**Issue:** The pattern `"}:"` is very broad and could match non-module files that happen to contain this string.~~

~~**Potential solution:**~~
~~- Require at least 2 patterns to match before considering a file a module~~
- Add negative patterns (strings that indicate a file is NOT a module)
- Weight patterns by specificity (e.g., `"options."` is more specific than `"}:"`)

**Severity:** Low - current heuristics work well in practice

---

## Error Handling

### ~~Graceful directory handling~~ ✅ Fixed

~~**Issue:** No graceful handling if a directory doesn't exist - will fail with a cryptic Nix error.~~

~~**Potential solution:**~~
~~- Check if directory exists before attempting to read~~
~~- Provide clear error message: "Modulon: Directory '/path/to/dir' does not exist"~~
~~- Optionally: warn instead of fail for missing directories~~

**Severity:** Low - but would improve user experience

---

## Documentation

### Clarify excludePaths behavior

**Issue:** `excludePaths` uses `hasInfix` which means `/foo/` matches anywhere in the path. This behavior could be clearer in documentation.

**Potential solution:**
- Document that patterns match anywhere in the path (not just at start/end)
- Add examples showing how `/foo/` matches `/bar/foo/baz.nix`
- Consider adding `excludePathPrefixes` and `excludePathSuffixes` for more precise control

**Severity:** Minor - documentation improvement

---

## Trivial

### ~~Typo in flake.nix~~ ✅ Fixed

~~**Issue:** Line 42 in flake.nix has "Hnady" instead of "Handy"~~

~~**Fix:** `pkgs.fx # Hnady CLI JSON visualizer` → `pkgs.fx # Handy CLI JSON visualizer`~~

**Severity:** Trivial

---

## Testing

### NixOS integration testing

**Current limitation:** Testing Modulon's NixOS module discovery requires a NixOS host or CI environment with NixOS support.

**Potential solutions:**
- Set up GitHub Actions with NixOS runner
- Use `nixos-rebuild build` in CI to validate module discovery
- Create mock NixOS evaluation tests that don't require full system

---

## Future Ideas

### Module metadata extraction

Extract and expose module metadata (options defined, services enabled, etc.) for documentation generation or introspection tools.

### Dependency analysis

Analyze module dependencies to detect circular imports or missing dependencies before evaluation fails.

### Watch mode

For development: watch directories and report when new modules are detected or existing ones change.
