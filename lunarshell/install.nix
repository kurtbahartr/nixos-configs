{ config, pkgs, ... }:
{
  # Install zsh
  programs.zsh.enable = true;

  # LunarShell stuff
  environment = {
    # Dots
    # Source: https://github.com/ohemilyy/LunarShell
    etc = {
      "zshrc.local".source = ./zshrc;
      "starship.toml".source = ./starship.toml;
      "profile.d/sshmotd.sh".source = ./sshmotd.sh;
      "bashrc.local".source = ./bashrc;
      "profile.d/lunar-env.sh".source = ./lunar-env.sh;
    };
    # Deps
    systemPackages = with pkgs; [
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
    ];
  };
}
