{
  lib,
  ...
}: {
  complement = set: universe:
    builtins.filter (x: !(builtins.elem x set)) universe
  # source: https://github.com/ryan4yin/nix-config/blob/main/lib/default.nix
  # use path relative to the root of the project
  relativeToRoot = lib.path.append ../.;
  scanPaths = path:
    builtins.map
    (f: (path + "/${f}"))
    (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          path: _type:
            (_type == "directory") # include directories
            || (
              (path != "default.nix") # ignore default.nix
              && (lib.strings.hasSuffix ".nix" path) # include .nix files
            )
        )
        (builtins.readDir path)));
}
