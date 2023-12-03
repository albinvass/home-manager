{ config, ... }:
{
  home.file."${config.xdg.dataHome}/applications" = {
    source = ./applications;
    recursive = true;
  };
}
