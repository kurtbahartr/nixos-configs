{
  description = "A simple NixOS flake";
  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
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
      url = "github:kurtbahartr/envycontrol";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-flatpak,
      zen-browser,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.st-denis-g770 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./configuration.nix
          ./hardware-configuration.nix
          ./lib/bootloader.nix
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
          ./lib/zapret.nix
          ./lunarshell/install.nix
          nix-flatpak.nixosModules.nix-flatpak
          ./lib/flatpak.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.linda = import ./hm/linda.nix;
          }
        ];
      };
    };
}
