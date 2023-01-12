# Replace sudo with doas (FreeBSD moment)

{ ... }:

{
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        # This is just convenient to have.
        persist = true;
      }];
    };
  };
}
