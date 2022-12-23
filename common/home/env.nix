# Local environment config!

{ ... }:

{
  # This is required for home manager to edit env.
  programs.bash.enable = true;

  # Replace nano with kakoune
  home.sessionVariables = {
    EDITOR = "kak";
  };

  home.shellAliases = {
    pause = "systemctl suspend";
  };
}
