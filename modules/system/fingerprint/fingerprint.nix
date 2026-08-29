{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.fingerprint;

  syncFprintdToLid = pkgs.writeShellScript "sync-fprintd-to-lid" ''
    if grep -q closed /proc/acpi/button/lid/*/state 2>/dev/null; then
      systemctl mask --now fprintd.service
    else
      systemctl unmask fprintd.service
    fi
  '';
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

    services.acpid.enable = true;
    services.acpid.lidEventCommands = "${syncFprintdToLid}";

    systemd.services.fprintd-lid-sync = {
      description = "Sync fprintd enabled/masked state with lid state";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${syncFprintdToLid}";
      };
    };
  };
}
