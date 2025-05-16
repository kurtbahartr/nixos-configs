{
  networking.hostName = "st-denis-g770"; # Define your hostname.
  networking.nameservers = [ "149.112.121.10#private.canadianshield.cira.ca" "149.112.122.10#private.canadianshield.cira.ca" "2620:10A:80BB::10#private.canadianshield.cira.ca" "2620:10A:80BC::10#private.canadianshield.cira.ca" ];

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
