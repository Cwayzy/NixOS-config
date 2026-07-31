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
  };

  config = lib.mkIf cfg.enable {
    fileSystems."/mnt/mods" = {
      device = "c-213j:/volume1/mods";
      fsType = "nfs";
      options = commonOptions;
    };

    fileSystems."/mnt/tesk" = {
      device = "c-213j:/volume1/kogudus";
      fsType = "nfs";
      options = commonOptions;
    };

    fileSystems."/mnt/kevin" = {
      device = "c-213j:/volume1/kevin";
      fsType = "nfs";
      options = commonOptions;
    };

    fileSystems."/mnt/backup" = {
      device = "c-213j:/volume1/backup";
      fsType = "nfs";
      options = commonOptions;
    };
  };
}
