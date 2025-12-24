{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    appimage-run
    qbittorrent
    mpv
    kopia-ui
    discord
    kitty
  ];
}
