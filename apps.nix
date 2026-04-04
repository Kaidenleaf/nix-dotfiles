{ pkgs, inputs, ... }:

let 
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in 
{
  imports = [
    inputs.dms.nixosModules.dank-material-shell
  ];
  programs.localsend.enable = true;
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  
  programs.niri.enable = true;
  programs.dank-material-shell = {
    enable = true;
    dgop.package = unstable.dgop;
  };

  environment.systemPackages = with pkgs; [
    appimage-run
    qbittorrent
    mpv
    neovim
    ghostty
    libreoffice-qt-fresh
    oh-my-posh
    distrobox
    ffmpeg
    wofi
    restic
    ryubing
    pnpm
    nodejs
    nautilus
    unstable.rclone
    unstable.equibop
    unstable.vscode
    unstable.brave
    unstable.droidcam
    unstable.linux-wallpaperengine
    unstable.easyeffects
    unstable.xwayland-satellite
    fuzzel
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
    "app.zen_browser.zen"
    "org.musicbrainz.Picard"
    "com.valvesoftware.Steam"
    "com.stremio.Stremio"
    { appId = "org.DolphinEmu.dolphin-emu"; origin = "dolphin-emu"; }
    "com.usebottles.bottles"
  ];

  programs.obs-studio = {
    enable = true;
    package = unstable.obs-studio;
    enableVirtualCamera = true;
    plugins = with unstable.obs-studio-plugins; [
      droidcam-obs
      obs-pipewire-audio-capture
    ];
  };

  services.syncthing = {
    enable = true;
    user = "kaiden";
    group = "users";
    dataDir = "/home/kaiden/Sync"; 
    configDir = "/home/kaiden/.config/syncthing";
    openDefaultPorts = true;
  };

  services.gnome.gnome-keyring.enable = true;
}

