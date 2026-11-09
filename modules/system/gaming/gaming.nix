{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.gaming;
in
{
  options.modules.system.gaming = {
    enable = lib.mkEnableOption "Enable gaming suite";
    wheel.enable = lib.mkEnableOption "Thrustmaster T300RS support (hid-tmff2 + Oversteer)";
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
      boot.kernelModules = [ "hid-tmff2" ];
      boot.blacklistedKernelModules = [ "hid-thrustmaster" ];

      services.udev.packages = [ pkgs.oversteer ];
      environment.systemPackages = [ pkgs.oversteer ];
    })
  ];
}
