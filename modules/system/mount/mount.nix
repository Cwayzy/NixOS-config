{ config, lib, ... }:
let
  nas = config.flake.meta.nas;

  commonOptions = [
    "vers=4"
    "_netdev"
    "x-systemd.automount"
    "noauto"
    "nofail"
    "x-systemd.after=tailscaled.service"
    "x-systemd.requires=tailscaled.service"
  ];

  shares = {
    home   = { mountPoint = "/mnt/home";   path = "/volume1/homes/kevin"; link = "nas-home"; };
    mods   = { mountPoint = "/mnt/mods";   path = "/volume1/mods";        link = "mods"; };
    tesk   = { mountPoint = "/mnt/tesk";   path = "/volume1/kogudus";     link = "tesk"; };
    backup = { mountPoint = "/mnt/backup"; path = "/volume1/backup";      link = "backup"; };
  };
in
{
  flake.modules.nixos = lib.mapAttrs' (name: s:
    lib.nameValuePair "mount-${name}" {
      fileSystems.${s.mountPoint} = {
        device = "${nas}:${s.path}";
        fsType = "nfs";
        options = commonOptions;
      };
    }) shares;

  flake.modules.homeManager = lib.mapAttrs' (name: s:
    lib.nameValuePair "mount-${name}-link" ({ config, ... }: {
      home.file.${s.link}.source = config.lib.file.mkOutOfStoreSymlink s.mountPoint;
    })) shares;
}
