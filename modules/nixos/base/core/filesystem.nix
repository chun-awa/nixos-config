{
  fileSystems = let
    rootFilesystem = {subvol}:
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [
        "noatime"
        "compress=zstd"
        "subvol=${subvol}"
      ];
    };
  in {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=25%" "mode=755" ];
    };
    "/nix" = rootFilesystem {subvol = "/nix";};
    "/persistent" = (rootFilesystem {subvol = "/persistent";}) // {
      neededForBoot = true;
    };
    "/var" = rootFilesystem {subvol = "/var";};
    "/home" = rootFilesystem {subvol = "/home";};
    "/swap" = rootFilesystem {subvol = "/swap";};
    "/boot" = rootFilesystem {subvol = "/boot";};
  };
  swapDevices = [{device = "/swap/swapfile";}];
}
