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
      foxundermoon.shell-format
      timonwong.shellcheck
      tamasfe.even-better-toml
      davidanson.vscode-markdownlint
      wakatime.vscode-wakatime
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
