{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      ovmf.packages = [pkgs.OVMFFull.fd];
    };
  };
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    qemu_kvm
    qemu
  ];
}
