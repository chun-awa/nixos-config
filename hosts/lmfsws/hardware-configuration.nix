{
  lib,
  config,
  ...
}: {
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = ["ntfs"];
  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-label/D";
    fsType = "ntfs3";
    options = ["rw" "prealloc" "discard" "uid=1000"];
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
