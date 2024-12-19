{inputs, ...}: {
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile "${inputs.tmux-config}/.tmux.conf";
  };
  home.file.".config/tmux/tmux.conf.local".source = "${inputs.dotfiles}/.tmux.conf.local";
}
