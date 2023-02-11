{ pkgs, ... }:

{
  programs.firefox.profiles.pie = {
    isDefault = true;
    bookmarks = import ./bookmarks.nix;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      adsum-notabs
      auto-tab-discard
      ublock-origin
    ];
    userChrome = builtins.readFile ./custom.css;
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
      # Disable DRM content
      "media.eme.enabled" = false;
      # Enable custom CSS
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      # Completely hide tab bar
      "browser.tabs.tabmanager.enabled" = false;
    };
  };
}
