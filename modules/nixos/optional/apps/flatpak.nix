{
  pkgs,
  lib,
  ...
}: {
  services.flatpak = {
    enable = true;
    remotes = lib.mkDefault [
      {
        name = "flathub";
        location = "https://mirror.sjtu.edu.cn/flathub/flathub.flatpakrepo";
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
          "fallback-x11"
          "!x11"
        ];
        Environment = {
          # Fix un-themed cursor in some Wayland apps
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
        };
      };
    };
    uninstallUnmanaged = true;
  };
}
