{ config, ... }:

{
  # Get out of my home dir!
  home.sessionVariables.LESSHSTFILE = "${config.xdg.stateHome}/lesshst";
}
