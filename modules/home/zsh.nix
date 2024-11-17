{
  pkgs,
  ...
}: let
  p10k-config = pkgs.fetchFromGitHub {
    owner = "chun-awa";
    repo = "dotfiles";
    sparseCheckout = [".p10k.zsh"];
    rev = "968ae30bf525b8da855886e974deef9241aee424";
    sha256 = "sha256-lHX8LO3RynuY8TNI4q2qm7nCyOON1KRv4vbkcotX/Nc=";
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
