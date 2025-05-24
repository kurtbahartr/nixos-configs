{ systemSettings, ... }:
{
  virtualisation = {
    # Distrobox requirements
    podman = {
      enable = true;
      dockerCompat = true;
    };
    # WayDroid
    waydroid.enable = true;
    # VirtualBox
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
      # KVM support requires disabling network interfaces.
      addNetworkInterface = false;
      enableKvm = true;
    };
  };
}
