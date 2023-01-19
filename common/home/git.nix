{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;

    aliases = {
      a = "add";
      # TODO: I don't know how hacky this is but it doesn't look good
      # "Add and commit"
      ac = "!git add . && git commit";
      # "Add and commit (fix)"
      acf = "!git add . && git commit --amend";
      c = "commit";
      # "Commit fix"
      cf = "commit --amend";
      d = "diff";
      l = "log";
      p = "push";
      r = "rebase -i";
      s = "status";
    };

    userName = "PoweredByPie";
    userEmail = "poweredbypie@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
