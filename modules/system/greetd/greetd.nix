{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.greetd;
in 
{
  options.modules.system.greetd = {
    enable = lib.mkEnableOption "greetd login manager with tuigreet";

    command = lib.mkOption {
      type = lib.types.str;
      default = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd Hyprland";
      description = "Command greetd runs to launch the session";
    };
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings.default_session.command = cfg.command;
    };
  };
}
