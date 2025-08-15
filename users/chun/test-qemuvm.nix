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
    (mylib.listNixFiles (mylib.relativeToRoot "modules/home/base"))
    (mylib.excludeModules "modules/home/optional" [
      (mylib.appendPath "apps" [
        "flatpak.nix"
      ])
    )
  ];

  home = {
    username = "chun";
    homeDirectory = "/home/chun";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
