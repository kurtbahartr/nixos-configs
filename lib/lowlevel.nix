{ systemSettings, pkgs, envycontrol, ... }:
{
  # Non-default Filesystems
  boot = {
    supportedFilesystems = [
      "ntfs"
    ];
    kernelPackages = pkgs.${systemSettings.kernelPkg};
    kernelParams = systemSettings.kernelParams;
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
    envycontrol.packages.${pkgs.system}.default
    exfatprogs
    (callPackage ../pkgs/odin4.nix { })
    (callPackage ../pkgs/qdl.nix { })
  ];
}
