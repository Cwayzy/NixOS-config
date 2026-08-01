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
        };

        listener = [
          {
            timeout = 600; # 10 minutes -> lock
            on-timeout = "pidof hyprlock || hyprlock";
          }
	        {
            timeout = 900; # 15 minutes -> hibernate
            on-timeout = "/usr/bin/systemctl hibernate";
          }
	        {
	          event = "lid_close";
	          on-event = "pidof hyprlock || hyprlock";
	        }
          {
            event = "lid_open";
            on-event = "hyprctl dispatch 'hl.dsp.dpms({ action = on })'";
          }
        ];
      };
    };
  };
}
