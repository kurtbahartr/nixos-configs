{ systemSettings, ... }:
{
  networking.hostName = systemSettings.hostname;
  networking.nameservers = systemSettings.dnsNameservers;

  # Enable networking
  networking.networkmanager.enable = true;

  # systemd-resolved
  services.resolved = {
    enable = true;
    dnsovertls = "true";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs = {
    # Install KDE Connect
    kdeconnect.enable = true;
  };
}
