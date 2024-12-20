{
  description = "chun-awa's NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.5.1";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "github:chun-awa/dotfiles?shallow=1";
      flake = false;
    };
    tmux-config = {
      url = "github:gpakosz/.tmux";
      flake = false;
    };
    wallpapers = {
      url = "gitlab:chun-awa/wallpapers?shallow=1";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    grub2-themes,
    nix-flatpak,
    plasma-manager,
    impermanence,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "x86_64-linux"
    ];
    inherit (nixpkgs) lib;
    mylib = import ./mylib {inherit lib;};
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
    specialArgs = {
      inherit
        inputs
        outputs
        nixpkgs
        mylib
        ;
    };
  in {
    inherit (specialArgs) mylib;
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = let
      nixosSystem = {hostname}:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager nix-flatpak.homeManagerModules.nix-flatpak];
            }

            nix-flatpak.nixosModules.nix-flatpak
            grub2-themes.nixosModules.default
            impermanence.nixosModules.impermanence

            ./hosts/${hostname}/configuration.nix
          ];
        };
    in {
      lmfsws = nixosSystem {hostname = "lmfsws";};
      test-qemuvm = nixosSystem {hostname = "test-qemuvm";};
    };
  };
}
