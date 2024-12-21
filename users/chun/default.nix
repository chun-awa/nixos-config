{
  pkgs,
  config,
  ...
}: {
  users.users.chun = {
    isNormalUser = true;
    password = "chun";
    shell = pkgs.zsh;
    extraGroups = ["wheel" "video" "audio" "games" "networkmanager"];
    packages = [pkgs.home-manager];
  };
  home-manager.users.chun = import ./${config.networking.hostName}.nix;
}
