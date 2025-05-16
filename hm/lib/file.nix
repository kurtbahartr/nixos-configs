{ config, pkgs, ...}:
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
      onChange = ''
        dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
        var Desktops = desktops();
        for (i=0;i<Desktops.length;i++) {
          d = Desktops[i];
          d.wallpaperPlugin = "org.kde.image";
          d.currentConfigGroup = Array("Wallpaper",
                                      "org.kde.image",
                                      "General");
          d.writeConfig("Image", "file://${config.home.homeDirectory}/.wallpaper");
      }'
      '';
    };
  };
}
