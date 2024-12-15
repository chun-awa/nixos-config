{
  lib,
  ...
}: rec {
  complement = set: universe: builtins.filter (x: !(builtins.elem x set)) universe;
  listNixFiles = dir:
    let
      entries = lib.attrNames (builtins.readDir dir);
      subdirs = lib.filter (name:
          (lib.filesystem.pathIsDirectory "${dir}/${name}")
      ) entries;
      files = builtins.map (f: (dir + "/${f}")) (lib.filter (name:
          (lib.strings.hasSuffix ".nix" name)
      ) (complement subdirs entries));
      filesInSubdirs = lib.concatLists (lib.map (name:
        listNixFiles (dir + "/${name}")
      ) subdirs);
    in
      files ++ filesInSubdirs;

  # source: https://github.com/ryan4yin/nix-config/blob/main/lib/default.nix
  # use path relative to the root of the project
  relativeToRoot = lib.path.append ../.;
  scanPaths = path:
    builtins.map (f: (path + "/${f}")) (builtins.attrNames
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
