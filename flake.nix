{
  description = "chun-awa's NixOS config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
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
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "x86_64-linux"
    ];
    inherit (nixpkgs) lib;
    mylib = import ./lib { inherit lib; };
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
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      lmfsws = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          home-manager.nixosModules.home-manager
          { home-manager.extraSpecialArgs = specialArgs; }
          ./hosts/lmfsws/configuration.nix
          grub2-themes.nixosModules.default
        ];
      };
    };
  };
}
