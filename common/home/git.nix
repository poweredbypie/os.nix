{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;

    aliases = {
      a = "add";
      c = "commit";
      l = "log";
      p = "push";
      r = "rebase";
      s = "status";
    };

    userName = "PoweredByPie";
    userEmail = "poweredbypie@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
