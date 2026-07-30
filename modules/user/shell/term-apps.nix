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
      swaybg #temp
      aerc
      ani-cli
      brightnessctl
      btop
      fastfetch
      git
      imv
      killall
      libnotify
      ncdu
      pwvucontrol
      poppler-utils
      rsync
      thunar
      wl-clipboard
      yazi
      zathura
      zip unzip
      zenity
    ];
  };
}
