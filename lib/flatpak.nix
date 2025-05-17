{ pkgs, ... }:
{
  # Flatpak stuff
  services.flatpak.enable = true;
  systemd.services.cider-flatpak = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      #if ! flatpak info sh.cider.genten; then
      #  flatpak install -y /etc/nixos/cider/cider-linux-x64.flatpak
      #fi
    '';
  };
}
