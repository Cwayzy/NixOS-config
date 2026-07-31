{ config, lib, pkgs, vars, ... }:
let
  cfg = config.modules.system.sddm;
in 
{
  options.modules.system.sddm = {
    enable = lib.mkEnableOption "SDDM display manager";

    autologin = lib.mkEnableOption "SDDM autologin";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    services.displayManager.autoLogin = lib.mkIf cfg.autologin {
      enable = true;
      user = vars.username;
    };

    services.displayManager.defaultSession = lib.mkIf cfg.autologin "hyprland";
  };
}
