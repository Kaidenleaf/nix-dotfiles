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
    lsp-plugins
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
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
      hash = "sha256-bzMqxWTqrJ1skZmRTXyEMCKStXpljbqe5r0Ve2cnBfM=";
    };
    configFile = "/etc/caddy/Caddyfile";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pipewire.extraConfig.pipewire."99-virtual-surround" = {
    "context.modules" = [
      {
        name = "libpipewire-module-filter-chain";
        flags = [ "nofail" ];
        args = {
          "node.description" = "Virtual Surround Sink";
          "media.name" = "Virtual Surround Sink";
          "filter.graph" = {
            nodes = [
              {
                type = "builtin";
                label = "copy";
                name = "copyFL";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyFR";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyFC";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyRL";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyRR";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copySL";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copySR";
              }
              {
                type = "builtin";
                label = "copy";
                name = "copyLFE";
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFL_L";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 0;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFL_R";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 1;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFR_L";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 8;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFR_R";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 7;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFC_L";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 6;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convFC_R";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 13;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convLFE_L";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 6;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convLFE_R";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 13;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convSL_L";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 2;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convSL_R";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 3;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convSR_L";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 10;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convSR_R";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 9;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convRL_L";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 4;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convRL_R";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 5;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convRR_L";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 12;
                };
              }
              {
                type = "builtin";
                label = "convolver";
                name = "convRR_R";
                config = {
                  filename = "/home/kaiden/.config/pipewire/atmos.wav";
                  channel = 11;
                };
              }
              {
                type = "builtin";
                label = "mixer";
                name = "mixL";
              }
              {
                type = "builtin";
                label = "mixer";
                name = "mixR";
              }
            ];
            links = [
              {
                output = "copyFL:Out";
                input = "convFL_L:In";
              }
              {
                output = "copyFL:Out";
                input = "convFL_R:In";
              }
              {
                output = "copyFR:Out";
                input = "convFR_L:In";
              }
              {
                output = "copyFR:Out";
                input = "convFR_R:In";
              }
              {
                output = "copyFC:Out";
                input = "convFC_L:In";
              }
              {
                output = "copyFC:Out";
                input = "convFC_R:In";
              }
              {
                output = "copyLFE:Out";
                input = "convLFE_L:In";
              }
              {
                output = "copyLFE:Out";
                input = "convLFE_R:In";
              }
              {
                output = "copySL:Out";
                input = "convSL_L:In";
              }
              {
                output = "copySL:Out";
                input = "convSL_R:In";
              }
              {
                output = "copySR:Out";
                input = "convSR_L:In";
              }
              {
                output = "copySR:Out";
                input = "convSR_R:In";
              }
              {
                output = "copyRL:Out";
                input = "convRL_L:In";
              }
              {
                output = "copyRL:Out";
                input = "convRL_R:In";
              }
              {
                output = "copyRR:Out";
                input = "convRR_L:In";
              }
              {
                output = "copyRR:Out";
                input = "convRR_R:In";
              }
              {
                output = "convFL_L:Out";
                input = "mixL:In 1";
              }
              {
                output = "convFL_R:Out";
                input = "mixR:In 1";
              }
              {
                output = "convSL_L:Out";
                input = "mixL:In 2";
              }
              {
                output = "convSL_R:Out";
                input = "mixR:In 2";
              }
              {
                output = "convRL_L:Out";
                input = "mixL:In 3";
              }
              {
                output = "convRL_R:Out";
                input = "mixR:In 3";
              }
              {
                output = "convFC_L:Out";
                input = "mixL:In 4";
              }
              {
                output = "convFC_R:Out";
                input = "mixR:In 4";
              }
              {
                output = "convFR_L:Out";
                input = "mixL:In 5";
              }
              {
                output = "convFR_R:Out";
                input = "mixR:In 5";
              }
              {
                output = "convSR_L:Out";
                input = "mixL:In 6";
              }
              {
                output = "convSR_R:Out";
                input = "mixR:In 6";
              }
              {
                output = "convRR_L:Out";
                input = "mixL:In 7";
              }
              {
                output = "convRR_R:Out";
                input = "mixR:In 7";
              }
              {
                output = "convLFE_L:Out";
                input = "mixL:In 8";
              }
              {
                output = "convLFE_R:Out";
                input = "mixR:In 8";
              }
            ];
            inputs = [
              "copyFL:In"
              "copyFR:In"
              "copyFC:In"
              "copyLFE:In"
              "copyRL:In"
              "copyRR:In"
              "copySL:In"
              "copySR:In"
            ];
            outputs = [
              "mixL:Out"
              "mixR:Out"
            ];
          };
          "capture.props" = {
            "node.name" = "effect_input.virtual-surround-7.1-hesuvi";
            "media.class" = "Audio/Sink";
            "audio.channels" = 8;
            "audio.position" = [
              "FL"
              "FR"
              "FC"
              "LFE"
              "RL"
              "RR"
              "SL"
              "SR"
            ];
          };
          "playback.props" = {
            "node.name" = "effect_output.virtual-surround-7.1-hesuvi";
            "node.passive" = true;
            "audio.channels" = 2;
            "audio.position" = [
              "FL"
              "FR"
            ];
          };
        };
      }
    ];
  };

}
