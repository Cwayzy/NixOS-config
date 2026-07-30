{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.user.zen;
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options.modules.user.zen = {
    enable = lib.mkEnableOption "Enable zen";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      addons.bitwarden
      addons.ublock-origin
      addons.sponsorblock
      addons.seventv
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies = {
        DisableTelemetry = true;
        DisableFireFoxStudies = true;
        DisablePocket = true;
      };

      profiles.default = {
        isDefault = true;
      
        settings = {
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = true;
          "browser.aboutConfig.showWarning" = false;
          "apz.force_disable_autoscroll" = false;
        };
      };
    };

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
