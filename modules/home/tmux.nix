{
  inputs,
  ...
}: {
  home.file.".tmux.conf.local".source = "${inputs.dotfiles}/.tmux.conf.local";
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile "${inputs.tmux-config}/.tmux.conf";
  };
}
