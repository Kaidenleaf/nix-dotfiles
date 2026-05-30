{
  description = "NixOS config with Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    helium-nix.url = "github:penal-colony/helium-nix";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-flatpak, stylix, agenix, ... } @ inputs: {
    nixosConfigurations.zenith = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./ollama.nix
        ./hosts/zenith/configuration.nix
        nix-flatpak.nixosModules.nix-flatpak
        stylix.nixosModules.stylix
	    ./noctalia.nix
	    agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.kaiden = import ./hosts/zenith/home.nix;
            backupFileExtension = "backup";
          };
        }
        {
	    nix.settings = {
	        extra-substituters = [ "https://helium-nix.cachix.org" ];
	        extra-trusted-public-keys = [ "helium-nix.cachix.org-1:a8YPjt9O4GPyX0u3gjg/aWpb14teU9aRiSG/MOaSFgw=" ];
	    };
        }

      ];
    };
  };
}
