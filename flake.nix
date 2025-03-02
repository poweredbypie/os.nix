{
  description = "pie's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scalpel = {
      url = "github:polygon/scalpel";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.sops-nix.follows = "sops-nix";
    };
  };

  outputs = { self, nixpkgs, nur, home-manager, rust-overlay, nixos-hardware, sops-nix, scalpel }:
    let
      mkSystem = name: system: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            { networking.hostName = name; }
            { sops.defaultSopsFile = ./sys/${name}/secrets.yaml; }
            sops-nix.nixosModules.sops
            ./modules
            ./sys/${name}
            # Set the hostname in the flake.
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                users.pie = {
                  imports = [
                    { networking.hostName = name; }
                    { sops.defaultSopsFile = ./sys/${name}/secrets.yaml; }
                    sops-nix.homeManagerModules.sops
                    ./modules/home
                    ./sys/${name}/home
                  ];
                };
                backupFileExtension = "hm-backup";
              };
              nixpkgs.overlays = [
                nur.overlays.default
                rust-overlay.overlays.default
                (import ./pkgs)
              ];
            }
          ] ++ extraModules;
        };
    in
    {
      packages.x86_64-linux.default = (import nixpkgs
        {
          system = "x86_64-linux";
          overlays = [
            (import ./pkgs)
          ];
        }).kakoune-lsp;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations =
        {
          # Desktop
          # verthe = mkSystem "verthe" "x86-64-linux" [ ];
          # Old laptop
          zen = mkSystem "zen" "x86-64-linux" [ ];
          # Laptop
          gear =
            let
              base = mkSystem "gear" "x86-64-linux" [
                nixos-hardware.nixosModules.framework-11th-gen-intel
              ];
            in
            base.extendModules {
              modules = [
                scalpel.nixosModules.scalpel
                ./sys/gear/scalpel.nix
              ];
              specialArgs = { prev = base; };
            };
          beep = mkSystem "beep" "x86-64-linux" [ ];
          cobble =
            let
              base = mkSystem "cobble" "x86-64-linux" [ ];
            in
            base.extendModules {
              modules = [
                scalpel.nixosModules.scalpel
                ./sys/cobble/scalpel.nix
              ];
              specialArgs = { prev = base; };
            };
        };
    };
}
