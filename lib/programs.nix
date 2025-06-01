{ pkgs, zen-browser, systemSettings, ... }:
{
  # Experimental flags
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs = {
    # Install Steam
    steam.enable = true;

    # Install direnv
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    # Install KClock
    kclock.enable = true;

    # Install virt-manager
    virt-manager.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    unrar
    p7zip
    fastfetch
    wpsoffice
    python312Full
    prismlauncher
    protonvpn-gui
    wine
    winetricks
    lutris
    # To provide ntlm_auth to Wine.
    # We won't be hosting an SMB share nor will we access one.
    # Refer to the relevant NixOS Wiki page if you want to host/access
    # SMB shares as well and remove the entry from here.
    samba
    zen-browser.packages.${pkgs.system}.default
    vlc
    vscode
    distrobox
    progress
    libnotify
    zenity
    killall
    kdePackages.plasma-browser-integration
    (callPackage ../pkgs/cider.nix { })
  ];
}
