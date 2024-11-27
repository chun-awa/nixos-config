{
  programs.alacritty = {
    enable = true;

    settings = {
      colors = {
        bright = {
          black   = "#767676";
          blue    = "#1A8FFF";
          cyan    = "#14FFFF";
          green   = "#23FD00";
          magenta = "#FD28FF";
          red     = "#F2201F";
          white   = "#FFFFFF";
          yellow  = "#FFFD00";
        };
        normal = {
          black   = "#000000";
          blue    = "#0D73CC";
          cyan    = "#0DCDCD";
          green   = "#19CB00";
          magenta = "#CB1ED1";
          red     = "#CC0403";
          white   = "#DDDDDD";
          yellow  = "#CECB00";
        };
        primary = {
          background = "#000000";
          foreground = "#FFFFFF";
        };
      };

      font = {
        size = 12;
        normal = {
          family = "Terminus";
          style = "Regular";
        };
      };

      env.TERM = "xterm-256color";
    };
  };
}
