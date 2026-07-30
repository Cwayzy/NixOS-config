{ config, lib, pkgs, ... }:
let
  parentCfg = config.modules.user.hypr-extras;

  cfg = config.modules.user.hypr-extras;
in 
{
  options.modules.user.hypr-extras.hyprpaper = {
    enable = lib.mkOption;
    type = lib.types.bool;
    default = parentCfg;
    description = "Enable hyprpaper"
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [hyprpaper];
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [ "$HOME/.config/hypr/wallpapers/dreamy.png" ];

        wallpaper = [
          {
            monitor  = "";
            path     = "$HOME/.config/hypr/wallpapers/dreamy.png";
            fit_mode = "fit";
          }
        ];
      };
    };
  };
}
