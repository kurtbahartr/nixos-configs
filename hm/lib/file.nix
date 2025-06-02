{ config, pkgs, userSettings, ... }:
{
  home.file = {
    ".zshrc".text = ''
      # Created by newuser for 5.9
    '';
    ".gitconfig".text = userSettings.git.extraConfig;
    ".local/share/fonts/mtextra.ttf".source = ../fonts/mtextra.ttf;
    ".local/share/fonts/symbol.ttf".source = ../fonts/symbol.ttf;
    ".local/share/fonts/Webdings_Regular.ttf".source = ../fonts/Webdings_Regular.ttf;
    ".local/share/fonts/Wingdings.ttf".source = ../fonts/Wingdings.ttf;
    ".local/share/fonts/Wingdings_2.ttf".source = ../fonts/Wingdings_2.ttf;
    ".local/share/fonts/Wingdings_3.ttf".source = ../fonts/Wingdings_3.ttf;
    ".mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json".text = ''
      {
        "name": "org.kde.plasma.browser_integration",
        "description": "Native connector for KDE Plasma",
        "path": "/run/current-system/sw/bin/plasma-browser-integration-host",
        "type": "stdio",
        "allowed_extensions": ["plasma-browser-integration@kde.org"]
      }
    '';
    ".wallpaper".source = ../wallpaper.png;
  };
}
