{ config, pkgs, ... }:
{
  home.file = {
    ".zshrc".text = ''
      # Created by newuser for 5.9
    '';
    ".gitconfig".text = ''
      [core]
      editor = "hx"
    '';
    ".local/share/fonts/mtextra.ttf".source = ../fonts/mtextra.ttf;
    ".local/share/fonts/symbol.ttf".source = ../fonts/symbol.ttf;
    ".local/share/fonts/Webdings_Regular.ttf".source = ../fonts/Webdings_Regular.ttf;
    ".local/share/fonts/Wingdings.ttf".source = ../fonts/Wingdings.ttf;
    ".local/share/fonts/Wingdings_2.ttf".source = ../fonts/Wingdings_2.ttf;
    ".local/share/fonts/Wingdings_3.ttf".source = ../fonts/Wingdings_3.ttf;
    ".wallpaper" = {
      source = ../wallpaper.jpg;
      #onChange = "${pkgs.kdePackages.plasma-workspace}/bin/plasma-apply-wallpaperimage ${config.home.homeDirectory}/.wallpaper";
    };
  };
}
