{
  pkgs,
  ...
}: let
  p10k-config = pkgs.fetchgit {
    owner = "chun-awa";
    repo = "dotfiles";
    sparseCheckout = [".p10k.zsh"];
    rev = "968ae30bf525b8da855886e974deef9241aee424";
    sha256 = "sha256-jN8tKyuJe8p3mzxqJYBdEhfJjiHcNOSNlNp9B6eXqCQ=";
  };
in {
  home.file.".p10k.zsh".source = "${p10k-config}/.p10k.zsh";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      c = "clear";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
