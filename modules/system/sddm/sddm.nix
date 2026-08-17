{ config, lib, pkgs, vars, ... }:
let
  cfg = config.modules.system.sddm;

  hyprlandEnabled = config.modules.system.desktop.hyprland.enable or false;
  plasmaEnabled = config.modules.system.desktop.plasma.enable or false;

  defaultSession =
    if hyprlandEnabled then "hyprland"
    else if plasmaEnabled then "plasma"
    else null;
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

    services.displayManager.defaultSession =
    lib.mkIf (cfg.autologin && defaultSession != null) defaultSession;
  };
}
