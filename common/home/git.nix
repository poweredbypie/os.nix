{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;

    aliases = {
      a = "add";
      c = "commit";
      p = "push";
      r = "rebase";
    };

    userName = "PoweredByPie";
    userEmail = "poweredbypie@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
