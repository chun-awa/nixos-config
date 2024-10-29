# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [
      "subvol=/root"
      "noatime"
      "compress=zstd"
    ];
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [
      "subvol=/home"
      "noatime"
      "compress=zstd"
    ];
  };
  fileSystems."/nix" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [
      "subvol=/nix"
      "noatime"
      "compress=zstd"
    ];
  };
  fileSystems."/swap" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [
      "subvol=/swap"
      "noatime"
    ];
  };
  swapDevices = [ { device = "/swap/swapfile"; } ];
  # Set your system kind (needed for flakes)
  nixpkgs.hostPlatform = "x86_64-linux";
}
