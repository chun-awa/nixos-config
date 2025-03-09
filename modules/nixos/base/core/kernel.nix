{
  pkgs,
  config,
  ...
}: {
  hardware.enableRedistributableFirmware = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;
    initrd.systemd.enable = true;
    # https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram
    kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };
}
