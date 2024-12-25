{pkgs, ...}: {
  home.packages = with pkgs; [
    flat-remix-icon-theme
  ];
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme = "Flat-Remix-Blue-Dark";
    };
  };
}
