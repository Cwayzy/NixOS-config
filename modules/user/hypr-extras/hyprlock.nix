{ config, lib, pkgs, ... }:
let
  parentCfg = config.modules.user.hypr-extras;

  cfg = config.modules.user.hypr-extras;
in 
{
  
  options.modules.user.hypr-extras.hyprlock = {
    enable = lib.mkOption {
    type = lib.types.bool;
    default = parentCfg;
    description = "Enable hyprlock";
    };
  };
  
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [hyprlock];
    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
        };

        background = [
          {
            monitor     = "";
            path        = "$HOME/.config/hypr/wallpapers/drift_2.jpg";
            blur_passes = 3;
            blur_size   = 4;
            brightness  = 0.3;
          }
        ];

        auth = {
          fingerprint = {
            enabled   = true;
            ready_message = "Touch fingerprint sensor";
            present_message = "Checking...";
            retry_delay = 250;
          };
        };

        label = [
          {
            monitor = "";
            text = "$TIME";
            color = "rgba(255, 255, 255, 0.85)";
            font_size = 90;
            font_family = "SF Pro Display Bold";
            position = "0, 80";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "cmd[update:1000] echo \"<span>$(date +'%A, %B, %d')</span>\"";
            color = "rgba(255, 255, 255, 0.55)";
            font-size = 22;
            font_family = "SF Pro Display Bold";
            position = "0, -20";
            halign = "center";
            valign = "center";
          }
        ];

        input-field = {
          monitor = "";
          size = "200, 40";
          outline_thickness = 0;
          inner_color = "rgba(255, 255, 255, 0.05)";
          font_color = "rgba(255, 255, 255, 0.8)";
          fade_on_empty = true;
          placeholder_text = "";
          hide_input = false;
          position = "0, -120";
          halign = "center";
          valign = "center";
        }; 
      };
    };
  };
}
