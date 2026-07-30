{ config, lib, pkgs, ... }:
let 
  cfg = config.modules.system.bluetooth;
in
{
  options.modules.system.bluetooth = {
    enable = lib.mkEnableOption "bluetooth support";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };

    services.blueman.enable = true;
  };
}
