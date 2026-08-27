{ config, lib, pkgs, ... }:
let
  parentCfg = config.modules.user.hypr-extras;

  cfg = config.modules.user.hypr-extras.hypridle;
in 
{
  options.modules.user.hypr-extras.hypridle = {
    enable = lib.mkOption {
    type = lib.types.bool;
    default = parentCfg.enable;
    description = "Enable hypridle";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;[hypridle];
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "pidof hyprlock || hyprlock";
          after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"on\" })'";
        };

        listener = [
          {
            timeout = 240; # 4 minutres -> dim
            on-timeout = "brightnessctl -s set 10%";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 600; # 10 minutes -> lock
            on-timeout = "pidof hyprlock || hyprlock";
          }
          {
            timeout = 630;
            on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"off\" })'";
            on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"on\" })'";
          }
	        {
            timeout = 900; # 15 minutes -> hibernate
            on-timeout = "systemctl hibernate";
          }
        ];
      };
    };
  };
}
