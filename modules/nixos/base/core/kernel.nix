{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
    initrd.systemd.enable = true;
    kernel.sysctl = {
      "vm.swappiness" = 100;
    };
  };
}
