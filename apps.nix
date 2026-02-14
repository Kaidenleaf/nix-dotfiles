{ pkgs, inputs, ... }:

let 
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in 
{
  programs.localsend.enable = true;
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
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
    ffmpeg
    inputs.quickshell.packages.${pkgs.system}.default
    wofi
    restic
    ryubing
  ];

  services.tailscale = {
    enable = true;
    package = unstable.tailscale;
  };

  services.flatpak.packages = [
    "com.spotify.Client"
    "org.prismlauncher.PrismLauncher"
    "md.obsidian.Obsidian"
    "it.mijorus.gearlever"
    "com.chatterino.chatterino"
    #"io.github.astralvixen.geforce-infinity"
    "app.zen_browser.zen"
  ];
}

