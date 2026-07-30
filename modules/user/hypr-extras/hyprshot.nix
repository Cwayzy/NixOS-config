{ config, lib, pkgs, ... }:
let
  parentCfg = config.modules.user.hypr-extras;

  cfg = config.modules.user.hypr-extras.hyprshot;
in 
{
  options.modules.user.hypr-extras.hyprshot = {
    enable = mkOption {
      type = lib.types.bool;
      default = parentCfg.enable;
      description = "Enable hyprshot";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.hyprshot ];
  };
}
