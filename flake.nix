{
  description = "NixOS config with Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    simple-wallpaper-engine = {
      url = "github:Maxnights/simple-linux-wallpaperengine-gui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-flatpak, ... }@inputs: {
    nixosConfigurations.zenith = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
	      nix-flatpak.nixosModules.nix-flatpak
	      home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
	          extraSpecialArgs = { inherit inputs; };
            users.kaiden = import ./home.nix;
            backupFileExtension = "backup";
          };
        }

      ];
    };
  };
}
