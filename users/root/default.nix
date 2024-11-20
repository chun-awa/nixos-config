{
  pkgs,
  config,
  ...
}: {
  users.users.root = {
    shell = pkgs.zsh;
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.root = import ./${config.networking.hostName}.nix;
}
