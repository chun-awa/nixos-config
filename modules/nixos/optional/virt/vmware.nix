{
  mylib,
  ...
}: {
  imports = [
    (mylib.relativeToRoot "modules/nixos/base/core/unfreepkgs.nix")
  ];
  modules.allowed-unfree-packages = [
    "vmware-workstation"
  ];
  virtualisation.vmware.host.enable = true;
}
