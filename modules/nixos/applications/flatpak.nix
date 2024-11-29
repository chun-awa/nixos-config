{
  pkgs,
  ...
}: let 
  flathub-gpg = pkgs.fetchurl {
    url = "https://mirror.sjtu.edu.cn/flathub/flathub.gpg";
    hash = "sha256-i9wgq8ThnAeWRgvrW/4OeqQThxaZnhnG8tvdeMxBrqo=";
  };
in {
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://mirror.sjtu.edu.cn/flathub/flathub.flatpakrepo";
        gpg-import = "${flathub-gpg}";
      }
    ];
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    packages = [
      "com.github.tchx84.Flatseal"
    ];
    overrides = {
      global = {
        # Force Wayland by default
        Context.sockets = [
          "wayland"
          "!x11"
          "!fallback-x11"
        ];
        Environment = {
          # Fix un-themed cursor in some Wayland apps
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
        };
      };
    };
  };
}
