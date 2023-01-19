{ pkgs, ... }:
{
  programs.firefox.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    auto-tab-discard
    ublock-origin
  ];
}
