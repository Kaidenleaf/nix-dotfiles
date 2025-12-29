{ pkgs, ... }:

{
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    vscode
    appimage-run
    qbittorrent
    mpv
    kopia-ui
    zed-editor
    neovim
    ghostty
    libreoffice-qt-fresh
    oh-my-posh
  ];
}
