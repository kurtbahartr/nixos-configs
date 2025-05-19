{ pkgs, inputs, ... }:
{
  # Non-default Filesystems
  boot = {
    supportedFilesystems = [
      "ntfs"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "kvm.enable_virt_at_load=0" ];
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
    exfatprogs
    (callPackage ../pkgs/odin4.nix { })
    (callPackage ../pkgs/qdl.nix { })
  ];
}
