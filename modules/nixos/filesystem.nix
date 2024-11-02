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
}