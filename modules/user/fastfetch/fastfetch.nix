{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.fastfetch;
in 
{
  options.modules.user.fastfetch = {
      enable = lib.mkEnableOption "Enable fastfetch";
    };

  config = lib.mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      settings = import ./config.nix;
    };
  };
}
