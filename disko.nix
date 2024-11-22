{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "128M";
              label = "EFI";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
              };
            };
            nixos = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-L" "nixos" "-f"];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = ["subvol=/root" "noatime" "compress=zstd"];
                  };
                  "/boot" = {
                    mountpoint = "/boot";
                    mountOptions = ["subvol=/boot" "noatime" "compress=zstd"];
                  };
                  "/var" = {
                    mountpoint = "/var";
                    mountOptions = ["subvol=/var" "noatime" "compress=zstd"];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["subvol=/home" "noatime" "compress=zstd"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["subvol=/nix" "noatime" "compress=zstd"];
                  };
                  "/swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = "1G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
