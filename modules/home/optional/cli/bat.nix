{
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Monokai Extended";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
      batgrep
      batdiff
    ];
  };
}
