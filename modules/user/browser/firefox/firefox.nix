{ config, lib, pkgs, ... }:
let
  parentCfg = config.modules.user.browser;
  cfg = config.modules.user.browser.firefox;
in
{
  options.modules.user.browser.firefox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = parentCfg.enable;
      description = "Enable firefox";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
