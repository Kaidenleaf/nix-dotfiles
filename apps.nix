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
    distrobox
    ffmpeg
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    wofi
    restic
    ryubing
    unstable.winboat
    pnpm
    nodejs
    unstable.equibop
  ];

  services.tailscale = {
    enable = true;
    package = unstable.tailscale;
  };

  services.flatpak.remotes = [
    { name = "dolphin-emu"; location = "https://flatpak.dolphin-emu.org/releases.flatpakrepo"; }
    { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
  ];

  services.flatpak.packages = [
    "com.spotify.Client"
    "org.prismlauncher.PrismLauncher"
    "md.obsidian.Obsidian"
    "it.mijorus.gearlever"
    "com.chatterino.chatterino"
    "io.github.astralvixen.geforce-infinity"
    "app.zen_browser.zen"
    "org.musicbrainz.Picard"
    "com.valvesoftware.Steam"
    "com.stremio.Stremio"
    { appId = "org.DolphinEmu.dolphin-emu"; origin = "dolphin-emu"; }
    "com.usebottles.bottles"
  ];
}

