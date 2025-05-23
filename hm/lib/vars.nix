{ config, userSettings, ... }:
{
  home.sessionVariables = {
    EDITOR = userSettings.editor;
  };

  home.shellAliases = {
    helix = "hx";
  };
}
