{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.waybar;
in 
{
  options.modules.user.waybar = {
    enable = lib.mkEnableOption "Enable waybar";
  };
  
  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings.mainBar= (import ./config.nix).mainBar // (import ./modules.nix);
      style = import ./style.nix;
    };
  };
}
