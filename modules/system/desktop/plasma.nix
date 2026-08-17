{ config, lib, pkgs, ... }:
let
  cfg = config.modules.system.desktop.plasma;
in
{
  options.modules.system.desktop.plasma = {
    enable = lib.mkEnableOption "Enable plasma";
  };

  config = lib.mkIf cfg.enable {
    services.desktopManager.plasma6.enable = true;
    services.power-profiles-daemon.enable = false;
    xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

    home-manager.users.kevin = {
      imports = [ ../../user/user.nix ];

      modules.user = {
        desktop.plasma.enable = true;
      };
    };
  };
}
