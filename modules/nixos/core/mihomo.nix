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
    lib.mkIf (builtins.pathExists configPath) { configFile = configPath; }
  };
}
