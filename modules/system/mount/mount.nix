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
    device = "192.168.88.10:/volume1/mods";
    fsType = "nfs";
    options = commonOptions;
    };
  };
}
