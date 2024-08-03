{ pkgs, config, ... }:

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
      ds = "diff --staged";
      l = "log";
      p = "push";
      r = "rebase -i";
      s = "status";
    };


    includes = [
      {
        condition = "gitdir:~/src/";
        contents = {
          user.name = "PoweredByPie";
          user.email = "poweredbypie@users.noreply.github.com";
        };
      }
      {
        condition = "gitdir:~/src/irl/";
        path = config.sops.secrets.git-irl.path;
      }
    ];

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
