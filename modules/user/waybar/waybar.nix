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
      settings.mainBar = (import ./mainBar.nix) // (import ./modules.nix);
      style = import ./style.nix;
    };

    xdg.configFile."waybar/secondBar.json".text = builtins.toJSON (
      (import ./secondBar.nix) // (import ./modules.nix)
    );
  };
}
