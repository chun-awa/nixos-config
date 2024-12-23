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
      common-cpu-amd
      common-cpu-amd-pstate
      common-cpu-amd-zenpower
      common-gpu-amd
      common-pc-laptop
      common-pc-laptop-ssd
    ])
    (mylib.listNixFiles (mylib.relativeToRoot "modules/nixos/base"))
    (mylib.excludeModules "modules/nixos/optional" [
      (mylib.appendPath "virt" [
        "virtualbox.nix"
        # TODO: implement allowUnfreePredicate package list (https://nixos.org/manual/nixpkgs/stable/#sec-allow-unfree)
        "vmware.nix"
      ])
    ])
    (mylib.appendPath (mylib.relativeToRoot "modules/nixos/hardware") [
      "amdvlk.nix"
    ])
    (mylib.appendPath (mylib.relativeToRoot "users") [
      "chun"
    ])
    ./hardware-configuration.nix
  ];
  networking.hostName = "lmfsws";
  environment.systemPackages = [inputs.home-manager.packages.${pkgs.system}.default];
  system.stateVersion = "24.11";
}
