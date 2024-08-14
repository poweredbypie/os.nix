{ ... }:

{
  programs.adb.enable = true;
  users.users.pie.extraGroups = [ "adbusers" ];
}
