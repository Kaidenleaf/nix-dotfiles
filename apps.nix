{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    appimage-run
  ];
}
