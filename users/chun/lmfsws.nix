{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  mylib,
  ...
}: {
  imports = lib.flatten [
    (map mylib.relativeToRoot [
      "modules/home/core/nixpkgs.nix"
      "modules/home/core/zsh.nix"
      "modules/home/core/tmux.nix"
      "modules/home/applications/alacritty.nix"
      "modules/home/applications/fcitx5.nix"
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
