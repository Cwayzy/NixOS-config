{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.discord;
  isOfiicialClient = cfg.package != "vesktop";
in 
{
  options.modules.user.discord = {
    enable = lib.mkEnableOption "Enable discord";

    package = lib.mkOption {
      type = lib.types.enum [ "discord" "discord-canary" "discord-ptb" "vesktop" ];
      default = "discord";
      description = "Which Discord client variant to install.";
    };

    withVencord = lib.mkEnableOption "Patch the client with vencord";
  };
  
  config = lib.mkIf cfg.enable {
    home.packages = [
      (
        if isOfiicialClient then 
          pkgs.${cfg.package}.override {
            withVencord = cfg.withVencord;
          }
        else
          pkgs.vesktop
      )
    ];
  };
}


