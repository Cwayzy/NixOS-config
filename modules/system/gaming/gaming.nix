{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.gaming;
in 
{
  options.modules.system.gaming = {
    enable = lib.mkEnableOption "Enable gaming suite";
  };

  config = lib.mkIf cfg.enable {
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
      oversteer
    ];

    hardware.xone.enable = true;
  };
}

