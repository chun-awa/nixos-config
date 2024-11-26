{
  pkgs,
  ...
}: {
  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      inter
      source-han-sans
      source-han-serif
      unifont
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "JetBrainsMono"
          "FiraCode"
        ];
      })
    ];

    fontconfig.defaultFonts = {
      serif = ["Source Han Serif SC" "Noto Color Emoji"];
      sansSerif = ["Inter" "Source Han Sans SC" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
