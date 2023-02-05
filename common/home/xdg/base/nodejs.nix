{ config, lib, ... }:

let
  npm = "npm";
  path = "${npm}/${npm}rc";

  inherit (lib.generators) toKeyValue;
  inherit (config) xdg;
in
{
  home.sessionVariables = {
    NODE_REPL_HISTORY = "${xdg.stateHome}/node_repl_history";
    NPM_CONFIG_USERCONFIG = "${xdg.configHome}/${path}";
  };

  xdg.configFile."${path}".text = toKeyValue { } {
    prefix = "${xdg.dataHome}/${npm}";
    cache = "${xdg.cacheHome}/${npm}";
  };
}
