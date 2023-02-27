{ config, ... }:

let
  inherit (config) xdg;
in
{
  home.sessionVariables.GOPATH = "${xdg.dataHome}/go";
}
