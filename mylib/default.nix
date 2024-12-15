{
  lib,
  ...
}: rec {
  # source: https://github.com/ryan4yin/nix-config/blob/main/lib/default.nix
  relativeToRoot = lib.path.append ../.;
  scanPaths = path:
    builtins.map (f: (path + "/${f}")) (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          path: _type:
            (_type == "directory")
            || (
              (path != "default.nix")
              && (lib.strings.hasSuffix ".nix" path)
            )
        )
        (builtins.readDir path)));

  complement = set: universe: builtins.filter (x: !(builtins.elem x set)) universe;
  listNixFiles = dir:
    let
      entries = scanPaths dir;
      subdirs = lib.filter lib.filesystem.pathIsDirectory entries;
      files = lib.filter (lib.strings.hasSuffix ".nix") (complement subdirs entries);
      filesInSubdirs = lib.concatLists (builtins.map listNixFiles subdirs);
    in
      files ++ filesInSubdirs;
  excludeModules = modulesPath: modules: complement modules (listNixFiles modulesPath);
}
