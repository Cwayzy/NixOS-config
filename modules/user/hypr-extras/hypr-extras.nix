{ config, lib, ... }:
let
  cfg = config.modules.user.hypr-extras;
in 
{
  options.modules.user.hypr-extras = {
    enable = mkEnableOption "Enable hypr-extras"
  };

  config = mkIf cfg.enable {
    imports = [
      ./hypridle.nix
      ./hyprlock.nix
      #./hyprpaper.nix
      ./files.nix
    ];
  };
 }
