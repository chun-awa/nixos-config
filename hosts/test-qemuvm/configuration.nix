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
    (with inputs.nixos-hardware.nixosModules; [
      common-pc-ssd
    ])
    (map mylib.relativeToRoot [
      "modules/nixos/core/nix.nix"
      "modules/nixos/core/nixpkgs.nix"
      "modules/nixos/core/filesystem.nix"
      "modules/nixos/core/bootloader.nix"
      "modules/nixos/core/kernel.nix"
      "modules/nixos/core/networking.nix"
      "modules/nixos/core/ssh.nix"
      "modules/nixos/core/time.nix"
      "modules/nixos/core/ntp.nix"
      "modules/nixos/core/console.nix"
      "modules/nixos/core/binfmt.nix"
      "modules/nixos/core/i18n.nix"
      "modules/nixos/desktop/fonts.nix"
      "modules/nixos/desktop/plasma6.nix"
      "modules/nixos/desktop/audio.nix"
      "modules/nixos/applications/pkgs.nix"
      "modules/nixos/applications/flatpak.nix"
      "users/chun"
    ])
    ./hardware-configuration.nix
  ];
  networking.hostName = "test-qemuvm";
  environment.systemPackages = with pkgs; [ inputs.home-manager.packages.${pkgs.system}.default ];
  system.stateVersion = "24.11";
}
