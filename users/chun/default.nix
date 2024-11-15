{
  pkgs,
  config,
  configLib,
  ...
}: {
  users.users.chun = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "video" "audio" "games" "networkmanager"];
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.chun = import (
    configLib.relativeToRoot "home/chun/${config.networking.hostName}.nix"
  );
}
