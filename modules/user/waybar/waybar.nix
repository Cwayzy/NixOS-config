{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.waybar;
in 
{
  options.modules.user.waybar = {
    enable = mkEnableOption "Enable waybar";
  };
  
  config = {
    programs.waybar = {
      enable = true;
      settings.mainBar= (import ./config.nix).mainBar // (import ./modules.nix);
      style = import ./style.nix;
    };
  };
}
