# Testing Modulon

Run the checks defined in `tests/default.nix` using the standard flake command:

```shell
nix flake check
```

## Understanding Output

By default, Nix only shows detailed build logs **if a check fails**. If `nix flake check` runs silently and exits with status code 0, all checks passed.

Check the exit code:

```shell
$ nix flake check
warning: Git tree '/home/cig0/workdir/cig0/modulon' is dirty
warning: The check omitted these incompatible systems: aarch64-darwin, aarch64-linux, x86_64-darwin
Use '--all-systems' to check all.

$ echo $?
0
```

## Viewing Check Output for Debugging

To see detailed output from a specific check even when it succeeds:

```bash
# Replace <system> with your actual system (e.g., x86_64-linux)
nix build .#checks.<system>.collect-simple-modules --rebuild -L
```

- `--rebuild` — Ignore cached results and run the build script again
- `-L` (or `--print-build-logs`) — Print full build logs (stdout/stderr)

**Example output:**

```shell
warning: Git tree '/path/to/modulon' is dirty
verify-module-collection> Expected: ["/nix/store/...-create-test-files/test-dir/module1.nix","/nix/store/...-create-test-files/test-dir/subdir/module2.nix"]
verify-module-collection> Actual:   ["/nix/store/...-create-test-files/test-dir/module1.nix","/nix/store/...-create-test-files/test-dir/subdir/module2.nix"]
verify-module-collection> Check passed!
```
