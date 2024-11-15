{
  pkgs,
  config,
  home-manager,
  ...
}: {
  users.users.chun = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "video" "audio" "games" "networkmanager"];
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.chun = import ./${config.networking.hostName}.nix;
}
