{ lib, ... }:

let
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
  fileSystems."/mnt/mods" = {
  device = "192.168.88.10:/volume1/mods";
  fsType = "nfs";
  options = commonOptions;
  };
}
