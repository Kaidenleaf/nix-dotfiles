{ inputs, config, pkgs, ... }: {
   home.stateVersion = "25.11";
   imports = [
      inputs.seanime.nixosModules.seanime # import this in home.nix
   ];
   modules.home.services.seanime.enable = true;
}
