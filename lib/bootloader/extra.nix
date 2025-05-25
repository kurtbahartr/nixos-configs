{ pkgs, ... }:
{
  boot.loader = {
    # Configuration for Limine
    limine = {
      maxGenerations = 10;
      style.interface.branding = "Linda's Excalibur";
    };
    # Configuration for GRUB
    grub = {
      efiSupport = pkgs.stdenv.hostPlatform.isEfi;
      timeoutStyle = "countdown";
      gfxpayloadBios = "keep";
      configurationLimit = 10;
      default = "saved";
      useOSProber = true;
    };
    # Cofiguration for systemd-boot
    systemd-boot.configurationLimit = 10;
    # Enable efiVars
    efi.canTouchEfiVariables = pkgs.stdenv.hostPlatform.isEfi;
  };
}
