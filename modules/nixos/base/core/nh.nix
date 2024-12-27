{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 1d --keep 2";
    };
    flake = "/home/chun/nixos-config";
  };
}