{pkgs, ...}: {
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-118n.psf.gz";
    keyMap = "us";
    earlySetup = true;
  };
}
