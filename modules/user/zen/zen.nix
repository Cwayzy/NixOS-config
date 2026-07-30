{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.user.zen;
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  options.modules.user.zen = {
    enable = lib.mkEnableOption "Enable zen";
  };

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies = {
        DisableTelemetry = true;
        DisableFireFoxStudies = true;
        DisablePocket = true;

        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };

          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
          };

          "firefox@betterttv.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/hummingbird-for-betterttv/latest.xpi";
            installation_mode = "force_installed";
          };

          "7tv@7tv.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/7tv/latest.xpi";
            installation_mode = "force_installed";
          };
        };
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
