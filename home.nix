{ pkgs, ... }:
{
  imports = [
    ./neovim
  ];

  home.username = "vass";
  home.homeDirectory = "/home/vass";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    kubectl
    helm
    azure-cli
    dig
  ];

  home.file = {
  };
  programs = {
    vscode.enable = true;
    rbw.enable = true;
    htop.enable = true;
    awscli.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    i3status-rust.enable = true;
    rofi.enable = true;
    k9s.enable = true;
    git = {
      enable = true;
      userEmail = "albinvass@gmail.com";
      userName = "Albin Vass";
    };
    zsh = {
      enable = true;
      enableCompletion = false;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "systemd"
          "rsync"
          "kubectl"
        ];
        theme = "robbyrussel";
      };
    };
  };

  home.sessionVariables = {};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
