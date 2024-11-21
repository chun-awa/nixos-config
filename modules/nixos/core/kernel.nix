{
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.initrd.systemd.enable = true;
}
