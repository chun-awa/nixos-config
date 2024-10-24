# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [
      "subvol=/root"
      "noatime"
      "compress=zstd"
    ]
  };

  # Set your system kind (needed for flakes)
  nixpkgs.hostPlatform = "x86_64-linux";
}
