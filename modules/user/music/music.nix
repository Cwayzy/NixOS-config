{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.music;
in
{
  options.modules.user.music = {
    enable = lib.mkEnableOption "Enable music apps";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
      pear-desktop
    ];
  };
}
