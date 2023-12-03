{ ... }:
{
  programs.zsh = {
    enable = true;
    initExtra = /* bash */ ''
      bw-unlock() {
        export BW_SESSION=$(bw unlock --raw)
      }

      bw-login() {
        export BW_SESSION=$(bw login --raw)
      }

      if [ -f "~/.secrets" ]; then
        source ~/.secrets
      fi
    '';
    enableCompletion = false;
    enableAutosuggestions = true;
    history.extended = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "kubectl"
        "ripgrep"
      ];
      theme = "robbyrussell";
    };
  };
}
