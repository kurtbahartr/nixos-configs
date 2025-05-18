{ pkgs, inputs, ... }:
{
  # Non-default Filesystems
  boot = {
    supportedFilesystems = [
      "ntfs"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # KDE Partition Manager
  programs.partition-manager.enable = true;

  # smartd service from smartmontools
  services.smartd.enable = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    android-tools
    pciutils
    nvme-cli
    smartmontools
    inputs.envycontrol.packages.${pkgs.system}.default
    exfat
    (callPackage ../pkgs/odin4.nix { })
  ];
}
