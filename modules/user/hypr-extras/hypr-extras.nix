{ config, lib, ... }:
let
  cfg = config.modules.user.hypr-extras;
in 
{
  options.modules.user.hypr-extras = {
    enable = lib.mkEnableOption "Enable hypr-extras";
  };

  config = lib.mkIf cfg.enable {
    imports = [
      ./hypridle.nix
      ./hyprlock.nix
      #./hyprpaper.nix
      ./files.nix
    ];
  };
 }
