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
    in
      if (builtins.pathExists configPath)
      then configPath
      else ./config.yaml;
  };
}
