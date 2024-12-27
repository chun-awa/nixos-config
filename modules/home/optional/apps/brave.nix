{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.unstable.brave;
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
    ];
  };
}
