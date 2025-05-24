{ config, pkgs, systemSettings, ... }:
{
  # Settings related to plymouth
  boot.plymouth = {
    enable = true;
    theme = "square_hud";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override{
        selected_themes = [ "square_hud" ];
      })
    ];
  };
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable Ly display manager
  services.displayManager.${systemSettings.displayManager}.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  # Install the Hyprland Window Manager.
  programs.hyprland.enable = true;

  # playerctl
  services.playerctld.enable = true;

  environment.systemPackages = with pkgs; [
    adw-gtk3
    brightnessctl
    xdg-desktop-portal-gtk
    cliphist
    wl-clipboard
    hyprshot
    hypridle
    kdePackages.qt6ct
    libsForQt5.qt5ct
    wezterm
    mako
    wofi
  ];

  # Configure keymap in X11
  services.xserver.xkb = systemSettings.xkb;

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

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  fonts = {
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
      # Fix emojis in Qt applications and Plasma shell.
      # https://superuser.com/questions/1800068/notification-box-in-kde-plasma-does-not-display-all-emoji-as-coloured
      # QTBUG-80434
      defaultFonts = {
        serif = [
          "Noto Sans"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Color Emoji"
        ];
        monospace = [
          "Hack Nerd Font Mono"
          "Noto Color Emoji"
        ];
      };
    };
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.hack
    ];
  };
}
