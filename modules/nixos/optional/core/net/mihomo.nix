{
  lib,
  pkgs,
  ...
}: {
  services.mihomo = {
    enable = true;
    webui = pkgs.metacubexd;
    configFile = /persistent/etc/mihomo/config.yaml;
  };
}
