{ config, lib, vars, ... }:

let
  cfg = config.modules.system.mount;
  hmLib = config.home-manager.users.${vars.username}.lib;

  commonOptions = [
  "vers=4"
  "_netdev"
  "x-systemd.automount"
  "noauto"
  "nofail"
  "x-systemd.after=tailscaled.service"
  "x-systemd.requires=tailscaled.service"
  ];

  mkMount = device: {
    inherit device;
    fsType = "nfs";
    options = commonOptions;
  };

  mkShareOptions = { mountDesc, defaultTarget }: {
    enable = lib.mkEnableOption mountDesc;
    link = {
      enable = lib.mkEnableOption "symlink this share into ${vars.username}'s home directory";
      target = lib.mkOption {
        type = lib.types.str;
        default = defaultTarget;
        description = "Name of the symlink under home directory";
      };
    };
  };
in
{
  options.modules.system.mount = {
    enable = lib.mkEnableOption "NFS mounts over tailscale";

    home = mkShareOptions { 
      mountDesc = "mount NAS homes/kevin at /mnt/kevin";
      defaultTarget = "nas-home";
    };

    mods = mkShareOptions { 
      mountDesc = "mount NAS mods share at /mnt/mods";
      defaultTarget = "mods";
    };

    tesk = mkShareOptions {
      mountDesc = "mount NAS kogudus share at /mnt/tesk";
      defaultTarget = "tesk";
    };

    backup = mkShareOptions {
      mountDesc = "mount NAS backup share at /mnt/backup";
      defaultTarget = "backup";
    };
  };

  config = lib.mkIf cfg.enable {
    fileSystems = lib.mkMerge [
      (lib.mkIf cfg.home.enable   { "/mnt/home"   = mkMount "c-213j:/volume1/homes/kevin"; })
      (lib.mkIf cfg.mods.enable   { "/mnt/mods"   = mkMount "c-213j:/volume1/mods"; })
      (lib.mkIf cfg.tesk.enable   { "/mnt/tesk"   = mkMount "c-213j:/volume1/kogudus"; })
      (lib.mkIf cfg.backup.enable { "/mnt/backup" = mkMount "c-213j:/volume1/backup"; })
    ];

    home-manager.users.${vars.username}.home.file = lib.mkMerge [
      (lib.mkIf cfg.home.link.enable {
        "${cfg.home.link.target}".source = hmLib.file.mkOutOfStoreSymlink "/mnt/home";
      })
      (lib.mkIf cfg.mods.link.enable {
        "${cfg.mods.link.target}".source = hmLib.file.mkOutOfStoreSymlink "/mnt/mods";
      })
      (lib.mkIf cfg.tesk.link.enable {
        "${cfg.tesk.link.target}".source = hmLib.file.mkOutOfStoreSymlink "/mnt/tesk";
      })
      (lib.mkIf cfg.backup.link.enable {
        "${cfg.backup.link.target}".source = hmLib.file.mkOutOfStoreSymlink "/mnt/backup";
      })
    ];
  };
}
