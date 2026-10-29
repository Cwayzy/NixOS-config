{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.easyeffects;
in
{
  options.modules.user.easyeffects = {
    enable = lib.mkEnableOption "Enable EasyEffects";

    preset = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Input preset to load on start";
    };
  };

  config = lib.mkIf cfg.enable {
    services.easyeffects = {
      enable = true;
      preset = cfg.preset;
    };
  };
}
