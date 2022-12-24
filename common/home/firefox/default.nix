{ pkgs, ... }:

{
  home.packages = [pkgs.firefox];

  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      auto-tab-discard
      ublock-origin
    ];
    profiles.pie = {
      isDefault = true;
      settings = {
        # Use Zathura instead
        "pdfjs.disabled" = true;
        # Disable Pocket stuff
        "extensions.pocket.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        # Disable Firefox view thing
        "browser.tabs.firefox-view" = false;
        # Only use HTTPS by default
        "dom.security.https_only_mode" = true;
        # Smooth scroll sucks!!!
        "general.smoothScroll" = false;
        # These correspond to the "strict mode" in about:preferences.
        "privacy.annotate_channels.strict_list.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;
        "privacy.query_stripping.enabled" = true;
        "privacy.query_stripping.enabled.pbmode" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
    };
  };
}
