{
  config,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      initial_session = {
        command = "startplasma-wayland";
        # TODO: make this not hard-coded
        user = "chun";
      };
      default_session = {
        command = builtins.concatStringsSep " " [
          "${tgreet}/bin/tuigreet"
          "--time --time-format '%Y-%m-%d %H:%M:%S'"
          "--asterisks"
          "--window-padding 2"
          "--container-padding 2"
          "--remember --remember-session"
          "--sessions ${config.services.xserver.displayManager.sessionData.desktops}/share/wayland-sessions"
          "--xsessions ${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions"
          "--theme 'border=blue;container=black;text=white;time=yellow;prompt=magenta;input=gray;action=blue;button=yellow'"
        ];
        user = "greeter";
      };
    };
  };
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
