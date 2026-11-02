{ config, lib, pkgs, ... }:
let
  parentCfg = config.modules.user.hypr-extras;

  cfg = config.modules.user.hypr-extras.hyprpaper;
in 
{
  options.modules.user.hypr-extras.hyprpaper = {
    enable = lib.mkOption {
    type = lib.types.bool;
    default = parentCfg.enable;
    description = "Enable hyprpaper";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [hyprpaper];
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [ "$HOME/.dotfiles/modules/user/hypr-extras/wallpapers/nix.png" ];

        wallpaper = [
          {
            monitor  = "";
            path     = "$HOME/.dotfiles/modules/user/hypr-extras/wallpapers/nix.png";
            fit_mode = "fit";
          }
        ];
      };
    };
  };
}
