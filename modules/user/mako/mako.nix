{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.mako;
in 
{
  options.modules.user.mako = {
    enable = lib.mkEnableOption "Enable mako";
  };

  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;
      settings = import ./config.nix;
    };
  };
}
