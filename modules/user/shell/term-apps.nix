{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.term-apps;
in 
{
  options.modules.user.term-apps = {
    enable = lib.mkEnableOption "Enable term-apps";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      aerc
      ani-cli
      brightnessctl
      btop
      fastfetch
      git
      killall
      libnotify
      ncdu
      poppler-utils
      rsync
      yazi
      zip unzip
    ];
  };
}
