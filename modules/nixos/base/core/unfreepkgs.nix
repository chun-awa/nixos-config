{
  config,
  lib,
  ...
}: {
  options.modules.allowed-unfree-packages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
  };

  config.nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) config.modules.allowed-unfree-packages;
}
