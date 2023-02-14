{ config, lib, ... }:

{
  home.sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
}
