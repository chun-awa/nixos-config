{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    git
    neofetch
    fastfetch
    just
    htop
    btop
    ncdu
    compsize
  ];
}
