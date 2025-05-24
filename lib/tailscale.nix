{ pkgs, tailscale, ... }:
{
  # Enable Tailscale
  services.tailscale = {
    enable = true;
    package = tailscale.packages.${pkgs.system}.default;
    useRoutingFeatures = "client";
  };
}
