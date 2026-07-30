{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.hyprland;
in 
{
  options.modules.hyprland = {
    enable = lib.mkEnableOption "Hyprland window manager"

    withUWSM = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Launch Hyprland via UWSM for proper systemd session integration.";
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
