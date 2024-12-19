{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  mylib,
  ...
}: {
  imports = lib.flatten [
    (with inputs.nixos-hardware.nixosModules; [
      common-pc-ssd
    ])
    (mylib.listNixFiles (mylib.relativeToRoot "modules/nixos/base"))
    (mylib.excludeModules "modules/nixos/optional" [
      (mylib.appendPath "virt" [
        "virtualbox.nix"
        "vmware.nix"
        "qemu.nix"
        "docker.nix"
      ])
    ])
    (mylib.appendPath (mylib.relativeToRoot "users") [
      "chun"
    ])
    ./hardware-configuration.nix
  ];
  networking.hostName = "test-qemuvm";
  environment.systemPackages = with pkgs; [inputs.home-manager.packages.${pkgs.system}.default];
  system.stateVersion = "24.11";
}
