{ pkgs, ... }:
{
  imports = [
    ./desktop-files
  ];

  fonts.fontconfig.enable = true;

  home.username = "avass";
  home.homeDirectory = "/home/avass";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    kubectl
    kubernetes-helm
    azure-cli
    dig
    act
    actionlint
    gh
    git-review
    docker-compose
    python311
    poetry
    rustc
    cargo
    go
    yarn
    bitwarden-cli
  ];

  home.file = {
  };
  programs = {
    htop.enable = true;
    awscli.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep.enable = true;
    k9s.enable = true;
    git = {
      enable = true;
      userEmail = "albinvass@gmail.com";
      userName = "Albin Vass";
    };
  };

  home.sessionVariables = {};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
