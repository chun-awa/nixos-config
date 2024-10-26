# nixos-config
## Installation from NixOS LiveCD
Clone the repository:
```
git clone https://github.com/chun-awa/nixos-config
cd nixos-config
```

(Optional) **Wipe all the data** and use disko to partition the disk:
```
sudo nix -v --option substituters https://mirrors.ustc.edu.cn/nix-channels/store --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko disko.nix
```

Run nixos-install:
```
sudo nixos-install -v --option substituters https://mirrors.ustc.edu.cn/nix-channels/store --flake .#nixos
```
