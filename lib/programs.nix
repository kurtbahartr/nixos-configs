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
    efibootmgr
    fastfetch
    wpsoffice
    android-tools
    python312Full
    prismlauncher
    wine
    winetricks
    inputs.zen-browser.packages.${pkgs.system}.default
    exfat
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
