{ ... }:

{
  # TODO: This is really bad!
  # We shouldn't be referring to a home directory as a mountpoint.
  # Potential solution: Make a /docs folder? But make it rwx for the users group?
  fileSystems =
    let
      perms = [
        "uid=pie"
        "gid=users"
      ];
    in
    {
      "/home/pie/docs" = {
        label = "bridge";
        options = perms;
      };
      "/home/pie/seagate" = {
        label = "seagate";
        fsType = "ntfs3";
        options = perms ++ [
          # TODO: `noatime` might be beneficial to load times? Try later
          # Osu reference??
          "nofail"
        ];
      };
    };
}
