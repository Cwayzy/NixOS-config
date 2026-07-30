{ config, lib, ... }:
let
  parentCfg = config,modules.user.hypr-extras;

  cfg = config.modules.user.hypr-extras.files;
in 
{
  options.modules.user.hypr-extras.files = {
    enable = lib.mkOption;
      type = lib.types.bool;
      default = parentCfg;
      description = "Enable extra files";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."hypr/scripts" = {
      source = ./scripts;
      recursive = true;
    };

    xdg.configFile."hypr/wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
  };
}
