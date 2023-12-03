{ config, pkgs, ... }: {

  home.packages = with pkgs; [
      libsForQt5.konsole
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  home.file = {
    "${config.xdg.dataHome}/konsole/avass.profile" = {
        source = ./avass.profile;
    };
    "${config.xdg.dataHome}/konsole/avass.colorscheme" = {
        source = ./avass.colorscheme;
    };
  };
}
