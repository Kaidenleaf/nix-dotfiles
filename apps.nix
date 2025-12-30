{ pkgs, inputs, ... }:

let 
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in 
{
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    unstable.vscode
    appimage-run
    qbittorrent
    mpv
    kopia-ui
    neovim
    ghostty
    libreoffice-qt-fresh
    oh-my-posh
    direnv
    nix-direnv
    distrobox
    homebank
  ];
}

