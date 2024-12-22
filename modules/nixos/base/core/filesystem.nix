{
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
