{
  pkgs,
  config,
  ...
}: {
  hardware.enableRedistributableFirmware = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;
    initrd.systemd.enable = true;
    kernel.sysctl = {
      "vm.swappiness" = 100;
    };
  };
}
