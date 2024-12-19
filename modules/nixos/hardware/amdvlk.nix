{pkgs, ...}: {
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];
}
