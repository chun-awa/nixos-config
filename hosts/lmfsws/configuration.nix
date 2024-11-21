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
      common-cpu-amd
      common-cpu-amd-pstate
      common-gpu-amd
      common-pc-laptop
      common-pc-laptop-acpi_call
      common-pc-laptop-ssd
    ])
    (map mylib.relativeToRoot [
      "modules/nixos/core/nix.nix"
      "modules/nixos/core/filesystem.nix"
      "modules/nixos/core/bootloader.nix"
      "modules/nixos/core/kernel.nix"
      "modules/nixos/core/networking.nix"
      "modules/nixos/core/ssh.nix"
      "modules/nixos/core/console.nix"
      "modules/nixos/core/binfmt.nix"
      "modules/nixos/core/zram.nix"
      "modules/nixos/core/i18n.nix"
      "modules/nixos/hardware/amdvlk.nix"
      "modules/nixos/desktop/x11desktop.nix"
      "modules/nixos/desktop/audio.nix"
      "modules/nixos/applications/fcitx5.nix"
      "modules/nixos/applications/wine.nix"
      "modules/nixos/virtualisation/qemu.nix"
      "modules/nixos/virtualisation/docker.nix"
      "users/chun"
    ])
    ./hardware-configuration.nix
  ];
  networking.hostName = "lmfsws";
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config.allowUnfree = true;
  };
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    git
    curl
    fastfetch
  ] ++ [ inputs.home-manager.packages.${pkgs.system}.default ];
  system.stateVersion = "24.05";
}
