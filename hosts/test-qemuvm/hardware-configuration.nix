{
  inputs,
  lib,
  config,
  modulesPath,
  ...
}: {
  imports = lib.flatten [
    (modulesPath + "/profiles/qemu-guest.nix")
    (with inputs.nixos-hardware.nixosModules; [
      common-pc-ssd
    ])
  ];

  boot.initrd.availableKernelModules = ["nvme" "uhci_hcd" "ehci_pci" "ahci" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];
  boot.loader.grub2-theme.customResolution = "1280x800";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems = let
    rootFilesystem = {subvol}: {
      device = "/dev/disk/by-label/nixos";
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
        device = "/dev/disk/by-label/nixos";
        fsType = "btrfs";
        options = ["subvolid=5"];
      };
      "/persistent" =
        (rootFilesystem {subvol = "/persistent";})
        // {
          neededForBoot = true;
        };
    }
    // lib.genAttrs ["/nix" "/var" "/home" "/swap" "/boot"] (subvol: rootFilesystem {inherit subvol;});
  swapDevices = [{device = "/swap/swapfile";}];
}
