{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.wofi;
in 
{
  options.modules.user.wofi = {
    enable = lib.mkEnableOption "Enable wofi";
  };

  config = lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;
      settings = import ./config.nix;
      style = import ./style.nix;
    };
  };
}
