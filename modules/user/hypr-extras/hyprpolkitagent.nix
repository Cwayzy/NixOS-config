{ config, lib, pkgs, ... }:
let
  parentCfg = config.modules.user.hypr-extras;

  cfg = config.modules.user.hypr-extras.hyprpolkitagent;
in 
{
  options.modules.user.hypr-extras.hyprpolkitagent = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = parentCfg.enable;
      description = "Enable hyprpolkitagent";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.hyprpolkitagent ];
  };
}
