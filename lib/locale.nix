{ systemSettings, ... }:
{
  # Set your time zone.
  time.timeZone = systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = "${systemSettings.locale}.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${systemSettings.locale}.UTF-8";
    LC_IDENTIFICATION = "${systemSettings.locale}.UTF-8";
    LC_MEASUREMENT = "${systemSettings.locale}.UTF-8";
    LC_MONETARY = "${systemSettings.locale}.UTF-8";
    LC_NAME = "${systemSettings.locale}.UTF-8";
    LC_NUMERIC = "${systemSettings.locale}.UTF-8";
    LC_PAPER = "${systemSettings.locale}.UTF-8";
    LC_TELEPHONE = "${systemSettings.locale}.UTF-8";
    LC_TIME = "${systemSettings.locale}.UTF-8";
  };
}
