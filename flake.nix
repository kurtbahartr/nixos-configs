{
  description = "A simple NixOS flake";
  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-flatpak, zen-browser, ... }@inputs: {
    nixosConfigurations.st-denis-g770 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        nix-flatpak.nixosModules.nix-flatpak
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        ./hardware-configuration.nix
        ./lib/bootloader.nix
        ./lib/cups.nix
        ./lib/flatpak.nix
        ./lib/gui.nix
        ./lib/locale.nix
        ./lib/networking.nix
        ./lib/nvidia.nix
        ./lib/programs.nix
        ./lib/ssh.nix
        ./lib/tailscale.nix
        ./lib/users.nix
        ./lib/virtualisation.nix
        ./lib/zapret.nix
        ./lunarshell/install.nix
      ];
    };
  };
}
