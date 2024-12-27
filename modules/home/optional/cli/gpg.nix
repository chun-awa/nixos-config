{pkgs, ...}: {
  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
  };
  services.gpg-agent = {
    enable = true;
    verbose = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    grabKeyboardAndMouse = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
