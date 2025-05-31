{
  description = "A simple NixOS flake";
  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # NixOS Unstable branch
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Flatpak for NixOS
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    # Zen Browser
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # EnvyControl
    envycontrol = {
      url = "github:bayasdev/envycontrol/?ref=v3.5.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tailscale = {
      url = "github:kurtbahartr/tailscale";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix-flatpak,
      zen-browser,
      home-manager,
      envycontrol,
      tailscale,
      ...
    }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.${systemSettings.architecture};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${systemSettings.architecture};
      nixpkgsConfig = {
        nixpkgs.config.allowUnfree = true;
      };
      systemSettings = {
        # Number of jobs Nix will invoke. Similar to `make -jN` where
        # N is a value for this variable.
        rebuildJobs = 4;
        # System architecture. You should probably not touch this.
        architecture = "x86_64-linux";
        # Bootloader. More extensive configuration can be seen in lib/bootloader.nix.
        bootloader = "systemd-boot";
        # Hostname. Adapt this to your installed system.
        hostname = "st-denis-g770";
        # Timezone. Format: Region/City
        timezone = "Europe/Istanbul";
        # Locale. You probably know this format if you have a good history with Linux.
        locale = "en_CA";
        # Kernel package to use. You should probably be content with the latest kernel.
        kernelPkg = "linuxPackages_latest";
        # Kernel parameters. You probably don't want to touch this unless you know what you're doing.
        kernelParams = [
          "kvm.enable_virt_at_load=0"
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];
        additionalKernelMods = [
          "f2fs"
        ];
        # Nameservers to use. The format for each entry is "IP#DoT.hostname".
        dnsNameservers = [
          "149.112.121.10#private.canadianshield.cira.ca"
          "149.112.122.10#private.canadianshield.cira.ca"
          "2620:10A:80BB::10#private.canadianshield.cira.ca"
          "2620:10A:80BC::10#private.canadianshield.cira.ca"
        ];
        # Options for NVIDIA driver.
        nvidia = {
          # Open source drivers brick laptops with NVIDIA OPTIMUS. Use with caution.
          ossDriver = false;
          # Driver package to use.
          driverPkg = "production";
          # Options for PRIME.
          prime = {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
            reverseSync.enable = false;
            allowExternalGpu = false;
            # Make sure to use the correct bus ID values for your system!
            # Get them using `sudo nix run 'nixpkgs#lshw' -- -c display`!
            # Leave blank the GPU types your system doesn't have!
            intelBusId = "PCI:0:2:0"; # Intel iGPU
            nvidiaBusId = "PCI:1:0:0"; # NVIDIA dGPU
            amdgpuBusId = ""; # AMD iGPU
          };
        };
        # Display manager to use.
        displayManager = "sddm";
        # X11 keymap configuration
        xkb = {
          layout = "us";
          variant = "";
        };
        # Use custom images for Waydroid, located in the waydroid/ folder.
        waydroid.useCustomImages = true;
        # Configuration for Zapret, a DPI bypass utility for Linux.
        zapret = {
          enable = true;
          params = [
            # Turkcell Superonline and Turk Telekom fiber home networks - Thanks cotunjr!
            "--dpi-desync=split2 --dpi-desync-ttl=5 --wssize 1:6 --dpi-desync-fooling=md5sig"
            "--dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-repeats=6"
            # eduroam - Samsun University
            "--dpi-desync=fake --dpi-desync-ttl=7 --dpi-desync-fake-tls=0x00000000"
            # Turk Telekom ADSL/VDSL and mobile data
            "--hostspell=hoSt"
            "--dpi-desync=fake --dpi-desync-ttl=3"
          ];
        };
      };
      userSettings = rec {
        # Username. Adapt this to your installed system.
        username = "linda";
        # Full name.
        fullname = "Linda St-Denis";
        # Extra groups the user will be added to.
        extraGroups = [
          "networkmanager"
          "wheel"
          "adbusers"
          "vboxusers"
        ];
        # Shell to be used by the user. LunarShell impacts both Bash and Zsh, so this is all up to you.
        shell = "zsh";
        # Git configuration
        git = {
          # Full name to be used by Git in commits
          fullName = "Bahar KURT";
          # Email to be used by Git in commits
          email = "kurtbahartr@users.noreply.github.com";
          # Extra configuration not covered by home-manager
          extraConfig = ''
            [core]
            editor = "hx"

            [color]
            ui = auto
          '';
        };
        # HyFetch configuration - You can get the values by running the first time setup.
        hyfetch = {
          # Gender flag to be picked.
          gender = "genderfae";
          # Light or dark?
          light_dark = "dark";
          # Lightness.
          lightness = 0.65;
          # Color alignment.
          colorMode = "horizontal";
          # Backend to use. Either neofetch, fastfetch or qwqfetch.
          backend = "fastfetch";
        };
        # Default editor in terminal shell.
        editor = "hx";
      };
    in {
      nixosConfigurations.${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
        system = systemSettings.architecture;
        modules = [
          {
            nix.settings.max-jobs = systemSettings.rebuildJobs;
          }
          nixpkgsConfig
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./configuration.nix
          ./hardware-configuration.nix
          ./lib/bootloader/config.nix
          ./lib/bootloader/extra.nix
          ./lib/cups.nix
          ./lib/gui.nix
          ./lib/locale.nix
          ./lib/lowlevel.nix
          ./lib/networking.nix
          ./lib/nvidia.nix
          ./lib/programs.nix
          ./lib/ssh.nix
          ./lib/tailscale.nix
          ./lib/users.nix
          ./lib/virtualisation.nix
          ./lib/waydroid-imgs.nix
          ./lib/zapret.nix
          ./lunarshell/install.nix
          nix-flatpak.nixosModules.nix-flatpak
          ./lib/flatpak.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${userSettings.username} = ./hm/${userSettings.username}.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit pkgs-unstable;
              inherit systemSettings;
              inherit userSettings;
            };
          }
        ];
        specialArgs = {
          inherit inputs;
          inherit zen-browser;
          inherit envycontrol;
          inherit tailscale;
          inherit pkgs-unstable;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
}
