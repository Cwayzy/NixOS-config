{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.usb;
in
{
  options.modules.system.usb = {
    enable = lib.mkEnableOption "removable USB automounting (udisks2 + gvfs)";
  };

  config = lib.mkIf cfg.enable {
    services.udisks2.enable = true;
    services.gvfs.enable = true;

    environment.systemPackages = with pkgs; [
      udiskie
    ];
  };
}
