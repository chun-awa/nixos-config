{pkgs, ...}: {
  home.packages = with pkgs; [
    flat-remix-icon-theme
    whitesur-gtk-theme
    bibata-cursors
  ];
}
