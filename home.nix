{ inputs, config, pkgs, ... }: {
   home.stateVersion = "25.11";
   imports = [
   ];
   stylix.targets.gtk.flatpakSupport.enable = false;
   xdg.configFile."ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/kaiden/nix-dotfiles/config/ghostty";
      recursive = true;
   };

   xdg.configFile."ohmyposh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/kaiden/nix-dotfiles/config/ohmyposh";
      recursive = true;
   };
}
