{ systemSettings, ... }:
{
  # Place custom images into their respective paths.
  environment.etc = if systemSettings.waydroid.useCustomImages then {
    "waydroid-extra/images/system.img".source = ../waydroid/system.img;
    "waydroid-extra/images/vendor.img".source = ../waydroid/vendor.img;
  } else { };
}
