{
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "i686-windows"
    "x86_64-windows"
  };
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
