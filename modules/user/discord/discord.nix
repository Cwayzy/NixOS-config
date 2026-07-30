{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.discord;
in 
{
  options.modules.user.discord = {
    enable = lib.mkEnableOption "Enable discord";

    package = lib.mkOption {
      type = lib.types.enum [ "discord" "discord-canary" "discord-ptb" "vesktop" ];
      default = "discord";
      description = "Which Discord client variant to install.";
    };
  };
  
  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.${cfg.package}
    ];
  };
}


