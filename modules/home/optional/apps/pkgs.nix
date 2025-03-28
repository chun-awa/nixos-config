{
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.flatten (with pkgs; [
    zip
    xz
    unzip
    p7zip
    zstd
    jq
    yq-go
    eza
    aria2
    nmap
    file
    tree
    gnupg
    cowsay
    lolcat
    fortune
    nix-tree
    nix-output-monitor
    nvd
    (with unstable; [
      go-musicfox
    ])
  ]);
}
