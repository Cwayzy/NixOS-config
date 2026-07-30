{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.hyprland;
in 
{
  options.modules.system.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland";

    withUWSM = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Launch Hyprland via UWSM";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = cfg.withUWSM;
    };
  };
}
