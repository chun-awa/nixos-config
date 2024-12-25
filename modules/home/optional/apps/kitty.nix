{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      package = null;
      size = 10.0;
    };
    settings = {
      background_opacity = 0.9;
      background_blur = 64;
      cursor_shape = "block";
      cursor_blink_interval = 0;
      shell_integration = "no-cursor";
      term = "xterm-256color";
      enable_audio_bell = false;
      update_check_interval = 0;
    };
  };
}
