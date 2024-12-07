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
    configFile = lib.mkIf (builtins.pathExists configPath) configPath;
  };
}
