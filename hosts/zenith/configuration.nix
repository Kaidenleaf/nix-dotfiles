# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../apps.nix
      ./filesystem.nix
      ../../restic.nix
      ../../rclone.nix
      ../../modules/nixos/stylix.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "zenith"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Costa_Rica";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CR.UTF-8";
    LC_IDENTIFICATION = "es_CR.UTF-8";
    LC_MEASUREMENT = "es_CR.UTF-8";
    LC_MONETARY = "es_CR.UTF-8";
    LC_NAME = "es_CR.UTF-8";
    LC_NUMERIC = "es_CR.UTF-8";
    LC_PAPER = "es_CR.UTF-8";
    LC_TELEPHONE = "es_CR.UTF-8";
    LC_TIME = "es_CR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
  };

  services.udisks2.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kaiden = {
    isNormalUser = true;
    description = "kaiden";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  # OpenTabletDriver
  hardware.opentabletdriver.enable = true;
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" "ntsync" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    inter
    liberation_ttf
    maple-mono.NF-unhinted
  ];
  fonts.enableDefaultPackages = true;
  fonts.fontDir.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  services.flatpak.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "Kaidenleaf";
      user.email = "129576524+Kaidenleaf@users.noreply.github.com";
    };
  };

  zramSwap.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 43211 47984 47989 47990 48010 ];
    allowedUDPPorts = [ 47998 47999 48000 48002 48010 ];
  };

  programs.fuse.userAllowOther = true;

  programs.nix-ld.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    hostKeys = [
      {
        type = "ed25519";
        path = "/etc/ssh/ssh_host_ed25519_key";
      }
    ];
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
