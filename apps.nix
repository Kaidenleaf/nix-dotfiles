{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  nur = import inputs.nur {
    nurpkgs = pkgs;
    pkgs = import inputs.nixpkgs {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
in
{
  programs.localsend.enable = true;
  programs.zsh.enable = true;
  programs.niri = {
    enable = true;
    package = unstable.niri;
  };
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.icu
    ]; 
  };

  environment.systemPackages = with pkgs; [
    udiskie
    ntfs3g
    qbittorrent
    mpv
    neovim
    ghostty
    libreoffice-qt-fresh
    oh-my-posh
    ffmpeg
    restic
    ryubing
    pnpm
    nodejs
    nautilus
    distrobox
    bibata-cursors
    yt-dlp
    uv
    borgbackup
    chatterino7
    nil
    nixd
    protonup-qt
    gpu-screen-recorder
    unstable.rclone
    unstable.equibop
    unstable.vscode
    unstable.droidcam
    unstable.linux-wallpaperengine
    unstable.easyeffects
    unstable.xwayland-satellite
    unstable.vicinae
    unstable.zed-editor
    unstable.feishin
    inputs.agenix.packages.${stdenv.hostPlatform.system}.default
    (nur.repos.Ev357.helium.override { enableWideVine = true; })
  ];

  services.tailscale = {
    enable = true;
    package = unstable.tailscale;
  };

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  services.flatpak.packages = [
    "com.spotify.Client"
    "org.prismlauncher.PrismLauncher"
    "md.obsidian.Obsidian"
    "it.mijorus.gearlever"
    "org.musicbrainz.Picard"
    "com.stremio.Stremio"
    "org.DolphinEmu.dolphin-emu"
    "com.usebottles.bottles"
    "com.bitwarden.desktop"
    "com.github.tchx84.Flatseal"
    "org.keepassxc.KeePassXC"
    "dev.lizardbyte.app.Sunshine"
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
  services.gvfs.enable = true;
}
