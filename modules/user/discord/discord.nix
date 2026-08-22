{ config, lib, pkgs, ... }:

let
  cfg = config.modules.user.discord;

  vesktop-x11 = pkgs.writeShellApplication {
    name = "vesktop-x11";
    runtimeInputs = [ pkgs.vesktop ];
    text = ''
      exec vesktop --ozone-platform=x11 "$@"
    '';
  };
in
{
  options.modules.user.discord = {
    enable = lib.mkEnableOption "Enable discord";

    package = lib.mkOption {
      type = lib.types.enum [
        "discord"
        "discord-canary"
        "discord-ptb"
        "vesktop"
        "vesktop-x11"
      ];
      default = "discord";
      description = "Which Discord client variant to install.";
    };

    withVencord = lib.mkEnableOption "Patch the client with vencord";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      (
        if cfg.package == "vesktop-x11" then
          vesktop-x11
        else
          pkgs.${cfg.package}.override {
            withVencord = cfg.withVencord;
        }
      )
    ];
  };
}
