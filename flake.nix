{
  description = "pie's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nur, home-manager }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    nixosConfigurations =
      let
        mkSystem = name: system:
          let
            args = {
              misc = ./misc;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./common
              ./sys/${name}
              # Set the hostname in the flake.
              {
                networking.hostName = name;
              }
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  users.pie = {
                    imports = [
                      ./common/home
                      ./sys/${name}/home
                    ];
                  };
                  extraSpecialArgs = args;
                };
                # Add NUR for Firefox plugins
                nixpkgs.overlays = [ nur.overlay ];
              }
            ];
            specialArgs = args;
          };
      in
      {
        # Desktop
        verthe = mkSystem "verthe" "x86-64-linux";
        # Laptop
        zen = mkSystem "zen" "x86-64-linux";
      };
  };
}
