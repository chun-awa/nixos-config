{
  lib,
  pkgs,
  ...
}: {
  services.mihomo = {
    enable = true;
    webui = pkgs.metacubexd;
    configFile = let
      configPath = /root/.config/mihomo/config.yaml;
    in lib.mkMerge [
      lib.mkIf (builtins.pathExists configPath) {
        configFile = configPath;
      }
      lib.mkIf (!builtins.pathExists configPath) {
        configFile = ./config.yaml;
      }
    ];
  };
}
