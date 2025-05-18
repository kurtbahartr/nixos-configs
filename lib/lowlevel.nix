{ pkgs, inputs, ... }:
{
  # Non-default Filesystems
  boot = {
    supportedFilesystems = [
      "ntfs"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  programs = {
    # KDE Partition Manager
    partition-manager.enable = true;

    # Android Tools
    adb.enable = true;
  };

  # smartd service from smartmontools
  services.smartd.enable = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    pciutils
    nvme-cli
    smartmontools
    inputs.envycontrol.packages.${pkgs.system}.default
    exfat
    (callPackage ../pkgs/odin4.nix { })
  ];
}
