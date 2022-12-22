# Replace sudo with doas (FreeBSD moment)

{ ... }:

{
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        groups = ["wheel"];
        # This is required for `nixos-rebuild` to work!
        keepEnv = true;
        # This is just convenient to have.
        persist = true;
      }];
    };
  };
}
