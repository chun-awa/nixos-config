{
  pkgs,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with inputs.nix-vscode-extensions.extensions.open-vsx-release.${pkgs.system}; [
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
    userSettings = {
      "update.mode" = "none";
      "extensions.autoUpdate" = false;
      "window.titleBarStyle" = "custom";
      "telemetry.telemetryLevel" = "off";

      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "terminal.integrated.shellIntegration.decorationsEnabled" = "never";
      "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "editor.fontSize" = 14;
      "editor.fontLigatures" = true;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixfmt" ];
          };
        };
      };
    };
  };
  home.packages = with pkgs; [
    nil
  ];
}
