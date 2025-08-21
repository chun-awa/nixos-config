{
  inputs,
  lib,
  config,
  modulesPath,
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
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = ["ntfs"];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems = let
    rootFilesystem = {subvol}: {
      device = "/dev/disk/by-label/miners";
      fsType = "btrfs";
      options = [
        "noatime"
        "compress=zstd"
        "subvol=${subvol}"
      ];
    };
  in
    {
      "/" = {
        device = "none";
        fsType = "tmpfs";
        options = ["defaults" "size=25%" "mode=755"];
      };
      "/btrfs_root" = {
        device = "/dev/disk/by-label/miners";
        fsType = "btrfs";
        options = ["subvolid=5"];
      };
      "/persistent" =
        (rootFilesystem {subvol = "/persistent";})
        // {
          neededForBoot = true;
        };
      "/ws" = {
        device = "/dev/disk/by-label/Workspace";
        fsType = "ntfs3";
        options = ["rw" "prealloc" "discard" "uid=1000" "gid=1000" "force"];
      };
      "/data" = {
        device = "/dev/disk/by-label/Data";
        fsType = "ntfs3";
        options = ["rw" "prealloc" "discard" "uid=1000" "gid=1000" "force"];
      };
    }
    // lib.genAttrs ["/nix" "/var" "/home" "/boot"] (subvol: rootFilesystem {inherit subvol;});
  swapDevices = [{device = "/dev/disk/by-label/swap";}];
}
