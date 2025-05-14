{ pkgs, inputs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental flags
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs = {
    # Install Steam
    steam.enable = true;

    # Install zsh
    zsh.enable = true;

    # Install KDE Connect
    kdeconnect.enable = true;

    # Install KDE Partition Manager
    partition-manager.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # TODO: Migrate some of these to users.users.linda.packages
  environment.systemPackages = with pkgs; [
    efibootmgr
    unrar
    fastfetch
    wpsoffice
    android-tools
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
    inputs.envycontrol.packages.${pkgs.system}.default
    exfat
    vscode
    direnv
    distrobox
    progress
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
    (callPackage ../pkgs/odin4.nix {})
  ];
}
