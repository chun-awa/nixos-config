{pkgs, ...}: {
  environment.systemPackages = with pkgs; [jdk8 jdk17 jdk];
  programs.java = {
    enable = true;
    package = pkgs.jdk;
  };
}
