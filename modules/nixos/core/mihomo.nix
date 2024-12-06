{
  lib,
  pkgs,
  ...
}: {
  services.mihomo = {
    enable = true;
    webui = pkgs.metacubexd;
    let
      configPath = "/root/.config/mihomo/config.yaml";
    in
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
