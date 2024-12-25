{
  pkgs,
  lib,
  config,
  mylib,
  ...
}: {
  imports = [
    (mylib.relativeToRoot "modules/nixos/base/core/unfreepkgs.nix")
  ];
  modules.allowed-unfree-packages = [
    "steam"
    "steam-unwrapped"
    "steam-original"
    "steam-run"
  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [proton-ge-bin];
    protontricks.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
