{pkgs, ...}: {
  environment.xfce.excludePackages = with pkgs.xfce; [
    mousepad
    parole
    ristretto
    xfce4-screenshooter
    xfce4-taskmanager
    xfce4-terminal
    xfwm4-themes
    xfce4-screensaver
  ];
  services.xserver = {
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
}
