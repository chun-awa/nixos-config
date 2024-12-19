{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.wayland
    wineWowPackages.fonts
    winetricks
  ];
}
