{
  mylib,
  ...
}: {
  nixpkgs = import mylib.relativeToRoot modules/nixos/core/nixpkgs.nix;
}
