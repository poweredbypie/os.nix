{ config, ... }:

{
  # I could use programs.bash.historyFile,
  # but that creates even more annoying files in my home dir.
  #
  # This only really works in nested bash sessions,
  # but I only use fish so it's fine.
  home.sessionVariables.HISTFILE = "${config.xdg.stateHome}/bash_history";
}
