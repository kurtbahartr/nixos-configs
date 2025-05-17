{ pkgs, inputs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental flags
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Install Steam
  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    unrar
    fastfetch
    wpsoffice
    python312Full
    prismlauncher
    protonvpn-gui
    wine
    winetricks
    # To provide ntlm_auth to Wine.
    # We won't be hosting an SMB share nor will we access one.
    # Refer to the relevant NixOS Wiki page if you want to host/access
    # SMB shares as well and remove the entry from here.
    samba
    inputs.zen-browser.packages.${pkgs.system}.default
    vscode
    direnv
    distrobox
    progress
    libnotify
    zenity
    kdePackages.plasma-browser-integration
  ];
}
