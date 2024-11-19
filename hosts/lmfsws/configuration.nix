{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  mylib,
  ...
}: {
  imports = (with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-cpu-amd-pstate
    common-gpu-amd
    common-pc-laptop
    common-pc-laptop-acpi_call
    common-pc-laptop-ssd
  ]) ++ [
    (mylib.relativeToRoot "modules/nixos")
    ./hardware-configuration.nix
    (mylib.relativeToRoot "users/chun")
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
