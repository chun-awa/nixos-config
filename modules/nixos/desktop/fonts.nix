{
  pkgs,
  lib,
  ...
}: {
  fonts = {
    enableDefaultPackages = lib.mkForce false;
    fontDir.enable = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      unifont
      terminus_font
      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "JetBrainsMono"
          "FiraCode"
        ];
      })
    ];

    fontconfig.defaultFonts = lib.mkForce {
      serif = ["Noto Serif" "Source Han Serif SC" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Source Han Sans SC" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
