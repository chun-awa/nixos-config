{
  description = "chun-awa's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    dotfiles = {
      url = "github:chun-awa/dotfiles?shallow=1";
      flake = false;
    };
    tmux-config = {
      url = "github:gpakosz/.tmux";
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
    nixvim,
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
              home-manager.sharedModules = [
                plasma-manager.homeManagerModules.plasma-manager
                nix-flatpak.homeManagerModules.nix-flatpak
                nixvim.homeManagerModules.nixvim
              ];
            }

            nix-flatpak.nixosModules.nix-flatpak
            grub2-themes.nixosModules.default
            impermanence.nixosModules.impermanence
            nixvim.nixosModules.nixvim

            ./hosts/${hostname}/configuration.nix
          ];
        };
    in
      lib.genAttrs (
        builtins.attrNames (builtins.readDir (mylib.relativeToRoot "hosts"))
      ) (hostname: nixosSystem {inherit hostname;});
  };
}
