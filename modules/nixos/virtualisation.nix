{
  pkgs,
  ...
}: {
  virtualisation = {
    vmware.host.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    qemu_kvm
    qemu
  ];
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "x86_64-windows"
  ];
}