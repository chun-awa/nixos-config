current_host := `hostnamectl hostname`

switch hostname=current_host:
  sudo nixos-rebuild switch -v --show-trace --no-write-lock-file --flake .#{{hostname}}

history:
  sudo nix profile history --profile /nix/var/nix/profiles/system

clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system

gc:
  sudo nix-collect-garbage
  nix-collect-garbage

disko:
  sudo nix -v --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko disko.nix

install hostname:
  sudo nixos-install -v --flake .#{{hostname}}

repl:
  nix repl -f '<nixpkgs>'
