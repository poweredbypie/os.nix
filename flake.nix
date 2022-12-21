{
  description = "pie's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.v4 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          # I think this allows home manager to pull from nixpkgs without the namespace?
          # Maybe?
          home-manager = {
            useGlobalPkgs = true;
            users.pie = import ./common/user
          }; 
        }
      ];
    };
  };
}
