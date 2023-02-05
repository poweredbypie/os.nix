{ config, lib, ... }:

let
  npm = "npm";
  rc = "${npm}/${npm}rc";

  inherit (lib.generators) toKeyValue;
  inherit (config) xdg;
in
{
  home.sessionVariables = {
    NODE_REPL_HISTORY = "${xdg.stateHome}/node_repl_history";
    NPM_CONFIG_USERCONFIG = "${xdg.configHome}/${rc}";
  };

  xdg.configFile."${rc}".text = toKeyValue { } {
    prefix = "${xdg.dataHome}/${npm}";
    cache = "${xdg.cacheHome}/${npm}";
  };
}
