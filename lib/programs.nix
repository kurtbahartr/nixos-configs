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
    vscode
    direnv
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
