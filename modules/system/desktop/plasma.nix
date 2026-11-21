{ self, config, ... }:
let
  username = config.flake.meta.username;
in
{
  flake.modules.nixos.plasma = { pkgs, ... }: {
    services.desktopManager.plasma6.enable = true;
    services.power-profiles-daemon.enable = false;
    xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

    home-manager.users.${username}.imports = [ self.modules.homeManager.plasma ];
  };

  flake.modules.homeManager.plasma = {
    qt.kde.settings.kwalletrc.Wallet.Enabled = false;
  };
}
