{ config, lib, pkgs, ... }:
let
  parentCfg = config.modules.user.hypr-extras;

  cfg = config.modules.user.hypr-extras.hyprpicker;
in 
{
  options.modules.user.hypr-extras.hyprpicker = {
    enable = mkOption {
      type = lib.types.bool;
      default = parentCfg.enable;
      description = "Enable hyprpicker";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.hyprpicker ];
  };
}
