{ config, pkgs, ... }:
{
  # Flatpak stuff
  services.flatpak.enable = true;
  systemd.services.cider-flatpak = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak install -y /etc/nixos/cider/cider-linux-x64.flatpak
    '';
  };
}