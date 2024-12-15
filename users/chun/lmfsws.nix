{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  utils,
  mylib,
  ...
}: {
  imports = lib.flatten [
    (mylib.listNixFiles mylib.relativeToRoot "modules/home/base")
    (mylib.excludeModules "modules/home" [
    ])
  ];

  home = {
    username = "chun";
    homeDirectory = "/home/chun";
  };
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
