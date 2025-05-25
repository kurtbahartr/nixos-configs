{ systemSettings, ... }:
{
  # Preferred bootloader from flake.
  boot.loader.${systemSettings.bootloader}.enable = true;
}
