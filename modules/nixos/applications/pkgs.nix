{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    git
    neofetch
    fastfetch
    htop
  ];
}
