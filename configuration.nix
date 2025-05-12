# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "st-denis-g770"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.nameservers = [ "149.112.121.10#private.canadianshield.cira.ca" "149.112.122.10#private.canadianshield.cira.ca" "2620:10A:80BB::10#private.canadianshield.cira.ca" "2620:10A:80BC::10#private.canadianshield.cira.ca" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # systemd-resolved
  services.resolved = {
    enable = true;
    dnsovertls = "true";
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

  # Flatpak stuff
  services.flatpak.enable = true;
  systemd.services.cider-flatpak = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak install -y /etc/nixos/cider/cider-linux-x64.flatpak
    '';
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # Distrobox
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Install WayDroid
  virtualisation.waydroid.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  #services.blueman.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.linda = {
    isNormalUser = true;
    description = "Linda St-Denis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Install steam
  programs.steam.enable = true;

  # Install zsh
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental flags
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    efibootmgr
    telegram-desktop
    helix
    tmate
    virtualbox
    discord
    hyfetch
    fastfetch
    wpsoffice
    distrobox
    ghostwriter
    android-tools
    python312Full
    python312Packages.notebook
    prismlauncher
    python312Packages.pyqt5
    libsForQt5.qt5.qttools
    python312Packages.spyder
    wine
    winetricks
    inputs.zen-browser.packages.${pkgs.system}.default
    exfat
    gh
    ### START LunarShell deps ###
    figlet
    jq
    sysstat
    curl
    wget
    htop
    neofetch
    tree
    unzip
    starship
    procps
    bc
    ### END LunarShell deps ###
    (callPackage ./pkgs/odin4.nix {})
  ];

  # LunarShell dots
  environment.etc = {
    "zshrc.local".source = ./lunarshell/zshrc;
    "starship.toml".source = ./lunarshell/starship.toml;
    "profile.d/sshmotd.sh".source = ./lunarshell/sshmotd.sh;
    "bashrc.local".source = ./lunarshell/bashrc;
    "profile.d/lunar-env.sh".source = ./lunarshell/lunar-env.sh;
  };

  fonts = {
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
    };
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
    ];
  };

  # Zapret!
  services.zapret.enable = true;
  services.zapret.params = [
    # Turkcell Superonline and Turk Telekom home networks - Thanks cotunjr!
    "--dpi-desync=split2 --dpi-desync-ttl=5 --wssize 1:6 --dpi-desync-fooling=md5sig"
    "--dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-repeats=6"
    # eduroam - Samsun University
    "--dpi-desync=fake --dpi-desync-ttl=7 --dpi-desync-fake-tls=0x00000000"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
