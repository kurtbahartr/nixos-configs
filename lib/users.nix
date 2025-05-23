{ pkgs, userSettings, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.fullname;
    extraGroups = userSettings.extraGroups;
    shell = pkgs.${userSettings.shell};
  };
}
