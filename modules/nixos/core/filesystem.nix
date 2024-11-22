{
  fileSystems = let
    baseConfig = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [
        "noatime"
        "compress=zstd"
      ];
    };
  in
  {
    "/" = baseConfig // {
      options = baseConfig.options ++ ["subvol=/root"];
    };
    "/boot" = baseConfig // {
      options = baseConfig.options ++ ["subvol=/boot"];
    };
    "/var" = baseConfig // {
      options = baseConfig.options ++ ["subvol=/var"];
    };
    "/home" = baseConfig // {
      options = baseConfig.options ++ ["subvol=/home"];
    };
    "/nix" = baseConfig // {
      options = baseConfig.options ++ ["subvol=/nix"];
    };
    "/swap" = baseConfig // {
      options = ["noatime" "subvol=/swap"];
    };
  };
  swapDevices = [ { device = "/swap/swapfile"; } ];
}
