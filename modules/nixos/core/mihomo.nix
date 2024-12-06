{
  lib,
  pkgs,
  ...
}: let
  configPath = "/root/.config/mihomo/config.yaml";
in {
  services.mihomo = {
    enable = true;
    webui = pkgs.metacubexd;
    lib.mkMerge [
      lib.mkIf (builtins.pathExists configPath) {
        configFile = configPath;
      }
      lib.mkIf (!builtins.pathExists configPath) {
        configFile = pkgs.writeText "config.yaml" ''
          mixed-port: 7890
        '';
      }
    ];
  };
}
