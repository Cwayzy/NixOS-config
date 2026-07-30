{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.kitty;
in 
{
  options.modules.user.kitty = {
    enable = lib.mkEnableOption "Enable kitty";
  };
  
  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
      };
    };
  };
}
