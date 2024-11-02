{
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;
  networking.nameservers = [
    "114.114.114.114"
    "1.1.1.1"
    "1.0.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];
  networking.hostName = "nixos";
}