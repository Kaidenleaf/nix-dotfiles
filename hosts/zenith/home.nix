{ inputs, config, pkgs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
   home.stateVersion = "25.11";
   imports = [
   ];
   xdg.configFile."ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/kaiden/nix-dotfiles/config/ghostty";
      recursive = true;
   };

   xdg.configFile."ohmyposh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/kaiden/nix-dotfiles/config/ohmyposh";
      recursive = true;
   };

   home.pointerCursor = {
       gtk.enable = true;
       package = pkgs.bibata-cursors;
       name = "Bibata-Modern-Classic";
       size = 24;
     };
}
