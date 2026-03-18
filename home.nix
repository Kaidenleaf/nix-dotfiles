{ inputs, config, pkgs, ... }: {
   home.stateVersion = "25.11";
   imports = [inputs.simple-wallpaper-engine.homeManagerModules.default];
   programs.simple-wallpaper-engine.enable = true;
}
