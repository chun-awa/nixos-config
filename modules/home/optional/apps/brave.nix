{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.unstable.brave;
  };
}
