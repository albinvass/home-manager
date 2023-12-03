{ config, ... }: {
  home.file."${config.xdg.dataHome}/konsole/avass.profile" = {
      source = ./profile;
  };
  home.file."${config.xdg.configHome}/konsole/avass.colorscheme" = {
      source = ./colorscheme;
  };
}
