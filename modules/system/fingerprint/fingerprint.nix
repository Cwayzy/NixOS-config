{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.fingerprint;
in
{
  options.modules.system.fingerprint = {
    enable = lib.mkEnableOption "Enable fingerprint login";
  };

  config = lib.mkIf cfg.enable {
    services.fprintd.enable = true;

    security.pam.services = {
      sudo.fprintAuth = true;
      sddm.fprintAuth = true;
      hyprlock.fprintAuth = true;
    };
  };
}
