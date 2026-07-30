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

    betterdiscord = {
      enable = lib.mkEnableOption "Enable BetterDiscord";

      autoInstall = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Automatically run betterdiscordctl";
      };

      pluginsDir = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to directory of .plugins.js";
      };

      themesDir = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Path to directory of .theme.css";
      };
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = with pkgs;
        [ (if cfg.package == "vesktop" then vesktop else pkgs.${cfg.package}) ]
        ++ lib.optional cfg.betterdiscord.enable betterdiscordctl;
    }

    (lib.mkIf (cfg.betterdiscord.enable && cfg.betterdiscord.pluginsDir != null) {
      home.file.".config/BetterDiscord/plugins" = {
        source = cfg.betterdiscord.pluginsDir;
        recursive = true;
      };
    })

    (lib.mkIf (cfg.betterdiscord.enable && cfg.betterdiscord.autoInstall) {
      home.activation.installBetterDiscord = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD ${pkgs.betterdiscordctl}/bin/betterdiscordctl install || true
        '';
    })
  ]);
}


