{ lib }:
{
  dirs ? [ ],
  excludePaths ? [ ],
  extraModules ? [ ],
  ...
}:
let
  # Filenames to exclude automatically (exact match)
  excludeFilenames = [
    "configuration.nix"
    "flake.nix"
    "hardware-configuration.nix"
    "home.nix"
  ];

  # Path patterns to exclude automatically (infix match)
  defaultExcludePaths = [
    ".git/"
    "/tests/"
  ];

  # Heuristic patterns to identify potential Nix modules based on content.
  # This is not foolproof but helps filter out non-module .nix files.
  modulePatterns = [
    "... }:"
    "}:"
    "config,"
    "lib,"
    "inputs,"
    "nixosConfig,"
    "pkgs,"
    "config = {"
    "home = {"
    "imports = ["
    "options."
  ];

  # Function to collect modules from a directory
  collectModules =
    {
      dir,
      excludePaths ? [ ],
    }:
    let
      # Combine user excludePaths with defaults
      allExcludePaths = defaultExcludePaths ++ excludePaths;

      # Check if a path contains any of the special paths that should be excluded
      isExcludedPath =
        path:
        let
          strPath = toString path;
        in
        builtins.any (excludePath: lib.strings.hasInfix excludePath strPath) allExcludePaths;

      # Check if a file is likely a Nix module based on content patterns
      isNixModule =
        file:
        let
          # Read file content once for efficiency
          content = builtins.readFile file;
        in
        !(lib.strings.hasInfix "@MODULON_SKIP" content) # Check if Modulon should skip the
        && builtins.any (pattern: lib.strings.hasInfix pattern content) modulePatterns; # Check against `modulePatterns` if any pattern exists in the content

      # Recursively collect .nix files from a directory
      collectModulesRec =
        path:
        let
          items = builtins.readDir path; # Read the directory contents

          processItem =
            name: type:
            let
              fullPath = path + "/${name}";
            in
            if type == "regular" && lib.hasSuffix ".nix" name && !(lib.elem name excludeFilenames) then
              # It's a potentially relevant .nix file
              if isExcludedPath fullPath then
                [ ] # Skip files in excluded paths
              else
                # Return path only if content matches module patterns
                lib.optional (isNixModule fullPath) fullPath
            else if type == "directory" then
              # Recurse into subdirectories
              collectModulesRec fullPath
            else
              [ ]; # Ignore other file types

          # Map over all items and flatten the resulting list of lists
          itemLists = lib.mapAttrsToList processItem items;
        in
        lib.flatten itemLists; # Flatten happens here now
    in
    collectModulesRec dir;
in
{
  # The final list of module paths to be imported
  imports =
    # Map over each directory and collect modules (already flattened)
    lib.concatMap (dir: collectModules { inherit dir excludePaths; }) dirs
    # Append any explicitly provided extra modules
    ++ extraModules;
}
