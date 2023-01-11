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

    extraConfig = {
      user = {
        email = "poweredbypie@users.noreply.github.com";
        name = "PoweredByPie";
      };
      init.defaultBranch = "main";
    };
  };
}
