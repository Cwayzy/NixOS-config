{ config, lib, pkgs, vars, ... }:
let
  cfg = config.modules.system.desktop.hyprland;
in 
{
  options.modules.system.desktop.hyprland = {
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

    home-manager.users.kevin = {
      imports = [ ../../user/user.nix ];
      modules.user = {
        desktop.hyprland.enable = true; #hyprland configs
        hypr-extras = {
          enable = true;
          hypridle.enable = true;
        };
        waybar.enable = true;
        wofi.enable = true;
        mako.enable = true;
      };
    };
  };
}
