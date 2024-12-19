{
  lib,
  config,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];
  boot.initrd.availableKernelModules = ["nvme" "uhci_hcd" "ehci_pci" "ahci" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
