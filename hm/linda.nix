{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "linda";
  home.homeDirectory = "/home/linda";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".zshrc".text = ''
      # Created by newuser for 5.9
    '';
    ".local/share/fonts/mtextra.ttf".source = ./fonts/mtextra.ttf;
    ".local/share/fonts/symbol.ttf".source = ./fonts/symbol.ttf;
    ".local/share/fonts/Webdings_Regular.ttf".source = ./fonts/Webdings_Regular.ttf;
    ".local/share/fonts/Wingdings.ttf".source = ./fonts/Wingdings.ttf;
    ".local/share/fonts/Wingdings_2.ttf".source = ./fonts/Wingdings_2.ttf;
    ".local/share/fonts/Wingdings_3.ttf".source = ./fonts/Wingdings_3.ttf;
    ".wallpaper" = {
      source = ./wallpaper.jpg;
      onChange = "${pkgs.kdePackages.plasma-workspace}/bin/plasma-apply-wallpaperimage ${config.home.homeDirectory}/.wallpaper";
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/linda/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    # Git
    git = {
      enable = true;
      userName = "Bahar KURT";
      userEmail = "kurtbahartr@users.noreply.github.com";
      # Git LFS
      lfs.enable = true;
    };
    # GitHub CLI
    gh.enable = true;
    # LazyGit
    lazygit.enable = true;
    # GnuPG
    gpg.enable = true;
    # SSH
    ssh.enable = true;
    # Helix
    helix = {
      enable = true;
      settings = {
        theme = "base16_transparent";
        editor = {
          mouse = false;
          bufferline = "always";
          true-color = true;
          color-modes = true;
          soft-wrap.enable = true;
          cursor-shape.insert = "bar";
        };
        keys.normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];
          C-g = [ ":new" ":insert-output lazygit" ":buffer-close!" ":redraw" ];
        };
      };
    };
    # Tmate
    tmate.enable = true;
    hyfetch = {
      enable = true;
      settings = {
        preset = "genderfae";
        mode = "rgb";
        light_dark = "dark";
        lightness = 0.65;
        color_align = {
          mode = "horizontal";
        };
        backend = "fastfetch";
      };
    };
    # Distrobox config is available only on unstable channel.
    #distrobox = {
    #  enable = true;
    #  containers = {
    #    ubuntu = {
    #      image = "ubuntu:latest";
    #      init_hooks = [
    #        "wget -O /tmp/bifrost.deb https://github.com/zacharee/SamloaderKotlin/releases/download/1.20.1/bifrost_1.20.1_amd64.deb"
    #        "apt update"
    #        "apt -y upgrade"
    #        "apt -y install /tmp/bifrost.deb"
    #        "rm /tmp/bifrost.deb"
    #      ];
    #    };
    #  };
    #};
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    kate
    kcalc
    distrobox
    telegram-desktop
    discord
    ghostwriter
    python312Packages.notebook
    python312Packages.pyqt5
    libsForQt5.qt5.qttools
    python312Packages.spyder
    transmission_4-qt6
  ];
}
