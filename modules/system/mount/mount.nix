{ config, lib, ... }:

let
  cfg = config.modules.system.mount;

  commonOptions = [
  "vers=4"
  "_netdev"
  "x-systemd.automount"
  "noauto"
  "nofail"
  "x-systemd.after=tailscaled.service"
  "x-systemd.requires=tailscaled.service"
  ];
in
{
  options.modules.system.mount = {
    enable = lib.mkEnableOption "NFS mounts over tailscale";

    home.enable = lib.mkEnableOption "mount NAS homes/kevin at /mnt/kevin";
    mods.enable = lib.mkEnableOption "mount NAS mods share at /mnt/mods";
    tesk.enable = lib.mkEnableOption "mount NAS kogudus share at /mnt/tesk";
    backup.enable = lib.mkEnableOption "mount NAS backup share at /mnt/backup";
  };

  config = lib.mkIf cfg.enable {
    fileSystems = lib.mkMerge [
      (lib.mkIf cfg.home.enable {
        "/mnt/home" = {
          device = "c-213j:/volume1/homes/kevin/";
          fsType = "nfs";
          options = commonOptions;
        };
      })

      (lib.mkIf cfg.mods.enable {
        "/mnt/mods" = {
          device = "c-213j:/volume1/mods";
          fsType = "nfs";
          options = commonOptions;
        };
      })

      (lib.mkIf cfg.tesk.enable {
        "/mnt/tesk" = {
          device = "c-213j:/volume1/kogudus";
          fsType = "nfs";
          options = commonOptions;
        };
      })

      (lib.mkIf cfg.backup.enable {
        "/mnt/backup" = {
          device = "c-213j:/volume1/backup";
          fsType = "nfs";
          options = commonOptions;
        };
      })
    ];
  };
}
