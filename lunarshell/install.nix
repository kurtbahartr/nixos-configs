{ config, pkgs, ... }:
{
  # LunarShell dots
  environment.etc = {
    "zshrc.local".source = ./zshrc;
    "starship.toml".source = ./starship.toml;
    "profile.d/sshmotd.sh".source = ./sshmotd.sh;
    "bashrc.local".source = ./bashrc;
    "profile.d/lunar-env.sh".source = ./lunar-env.sh;
  };
}
