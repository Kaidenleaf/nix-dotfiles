{
  description = "NixOS config with Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.zenith = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      #specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
