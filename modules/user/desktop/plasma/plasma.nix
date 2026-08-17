{ config, lib, pkgs, ... }:
let
  cfg = config.modules.user.desktop.plasma;
in
{
  options.modules.user.desktop.plasma = {
    enable = lib.mkEnableOption "Enable plasma config";
  };

  config = lib.mkIf cfg.enable {
    qt.kde.settings = {
      kwalletrc = {
        Wallet = {
          Enabled = false;
        };
      };
    };
  };
}
