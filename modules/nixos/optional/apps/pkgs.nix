{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    git
    neofetch
    fastfetch
    just
    htop
    ncdu
    compsize
  ];
}
