{
  mylib,
  ...
}: {
  imports = [ mylib.relativeToRoot "modules/nixos/core/nixpkgs.nix" ];
}
