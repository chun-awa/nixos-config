{pkgs, ...}: let
  persistentPath = "/persistent";
in {
  environment.persistence."${persistentPath}" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
    ];
    files = [
      "/etc/machine-id"
      # "/etc/shadow"
    ];
  };
  # hacks to prevent failed bind mount on /etc/shadow
  # https://github.com/nix-community/impermanence/issues/120#issuecomment-2382674299
  system.activationScripts = {
    etc_shadow = ''
      [ -f "/etc/shadow" ] && cp /etc/shadow ${persistentPath}/etc/shadow
      [ -f "${persistentPath}/etc/shadow" ] && cp ${persistentPath}/etc/shadow /etc/shadow
    '';

    users.deps = ["etc_shadow"];
  };

  systemd.services."etc_shadow_persistence" = {
    enable = true;
    description = "Persist /etc/shadow on shutdown.";
    wantedBy = ["multi-user.target"];
    path = [pkgs.util-linux];
    unitConfig.defaultDependencies = true;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # Service is stopped before shutdown
      ExecStop = pkgs.writeShellScript "persist_etc_shadow" ''
        mkdir -p "${persistentPath}/etc"
        cp /etc/shadow ${persistentPath}/etc/shadow
      '';
    };
  };
}
