{ systemSettings, ... }:
{
  # Zapret - Configure in flake.nix.
  services.zapret = systemSettings.zapret;
}
