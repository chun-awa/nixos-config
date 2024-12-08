{
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      ms-python.python
      ms-python.vscode-pylance
      ms-python.black-formatter
      Vue.volar
      foxundermoon.shell-format
      timonwong.shellcheck
      tamasfe.even-better-toml
      davidanson.vscode-markdownlint
      vivaxy.vscode-conventional-commits
      WakaTime.vscode-wakatime
      LeonardSSH.vscord
    ];
  };
}
