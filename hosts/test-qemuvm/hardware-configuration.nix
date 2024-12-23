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
  boot.loader.grub2-theme.customResolution = "1280x800";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
