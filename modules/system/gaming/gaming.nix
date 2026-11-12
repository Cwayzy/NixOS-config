{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.system.gaming;

  multishift = pkgs.python3Packages.buildPythonApplication {
    pname = "hid-velocityone-multi-shift";
    version = "0.1.0";
    pyproject = true;
    src = inputs.multishift;
    build-system = [ pkgs.python3Packages.setuptools ];
    dependencies = with pkgs.python3Packages; [ evdev hidapi ];
  };
in
{
  options.modules.system.gaming = {
    enable = lib.mkEnableOption "Enable gaming suite";
    wheel.enable = lib.mkEnableOption "Sim Racing Support (T300RS + Turtle Beach Multi-Shift)";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
        protontricks.enable = true;
      };

      programs.gamemode.enable = true;

      environment.systemPackages = with pkgs; [
        heroic
        gamescope
      ];

      hardware.xone.enable = true;
    })

    (lib.mkIf cfg.wheel.enable {
      boot.extraModulePackages = [ config.boot.kernelPackages.hid-tmff2 ];
      boot.kernelModules = [ "hid-tmff-new" ];
      boot.blacklistedKernelModules = [ "hid-thrustmaster" ];

      services.udev.packages = [ pkgs.oversteer ];
      environment.systemPackages = [ pkgs.oversteer ];

      hardware.uinput.enable = true;
      systemd.services.multishift = {
        description = "Turtle Beach VelocityOne Multi-Shift userspace driver";
        wantedBy = [ "multi-user.target" ];
        after = [ "systemd-udev-settle.service" ];
        serviceConfig = {
          ExecStart = lib.getExe multishift;
          Restart = "always";
          RestartSec = 3;
        };
      };
    })
  ];
}
